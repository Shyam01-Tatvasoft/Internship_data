using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Repository.Data;
using Repository.ViewModels;
using Service.Interfaces;

namespace Web.Controllers;

public class AuthenticationController : Controller
{
    private readonly IAuthenticationService _authService;
    private readonly IJWTService _jWTService;
    public AuthenticationController(IAuthenticationService authService, IJWTService jWTService)
    {
        _authService = authService;
        _jWTService = jWTService;
    }

    [HttpGet]
    public IActionResult Login()
    {
        var AuthToken = Request.Cookies["AuthToken"];
        if (!string.IsNullOrEmpty(AuthToken))
        {
            var (email, role, userId) = _jWTService.ValidateToken(AuthToken);
            if (email != null && role != null)
            {
                if(role == "Admin")
                    return RedirectToAction("Admin", "Home");
                return RedirectToAction("Index", "Home");
            }
        }
        return View();
    }

    [HttpPost]
    public async Task<IActionResult> Login(LoginViewModel model)
    {
        if (ModelState.IsValid)
        {
            try
            {
                User? user = await _authService.VerifyUser(model.Email, model.Password);
                if (user != null)
                {
                    string? token = await _jWTService.GenerateToken(model.Email);

                    if (string.IsNullOrEmpty(token))
                    {
                        return View(model);
                    }
                    Response.Cookies.Append("AuthToken", token, new CookieOptions
                    {
                        Secure = true,
                        Expires = DateTime.UtcNow.AddHours(3),
                    });

                    using (var client = new HttpClient())
                    {
                        client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
                    }
                    TempData["ToastrMessage"] = "Login successfully";
                    TempData["ToastrType"] = "success";
                    if(user.Role == "Admin")
                    return RedirectToAction("Admin", "Home");
                else
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    TempData["ToastrMessage"] = "Wrong credentials please try again";
                    TempData["ToastrType"] = "error";
                    return View(model);
                }
            }
            catch (System.Exception)
            {
                TempData["ToastrMessage"] = "Something Went Wrong";
                TempData["ToastrType"] = "error";
                return View(model);
            }
        }
        else
        {
            return View(model);
        }
    }

    public IActionResult Logout()
    {
        Response.Headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age=0";
        Response.Headers["Pragma"] = "no-cache";
        Response.Cookies.Delete("AuthToken");
        return RedirectToAction("Login", "Authentication");
    }
}
