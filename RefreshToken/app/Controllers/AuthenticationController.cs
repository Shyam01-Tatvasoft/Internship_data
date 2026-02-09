using app.Data;
using app.ViewModel;
using Microsoft.AspNetCore.Mvc;

namespace app.Controllers;

public class AuthenticationController : Controller
{
    private readonly DatabaseContext _context;

    public AuthenticationController(DatabaseContext context)
    {
        _context = context;
    }

    [HttpGet]
    public IActionResult Login()
    {
        return View();
    }

    [HttpPost]
    public IActionResult Login(LoginViewModel model)
    {
        if (!ModelState.IsValid)
        {
            return View(model);
        }
        else
        {
        return View();
            
        }
    }

    [HttpPost]
    public IActionResult Register()
    {
        return View();
    }

    public IActionResult Logout()
    {
        Response.Headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age=0";
        Response.Headers["Pragma"] = "no-cache";
        Response.Cookies.Delete("AuthToken");
        return RedirectToAction("Login", "Authentication");
    }
}
