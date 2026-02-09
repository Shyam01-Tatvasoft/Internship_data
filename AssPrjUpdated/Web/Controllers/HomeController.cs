using System.Diagnostics;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Web.Controllers;
[Authorize]
public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;

    public HomeController(ILogger<HomeController> logger)
    {
        _logger = logger;
    }

    public IActionResult Index()
    {
        return View();
    }

    [HttpGet]
    public IActionResult ErrorForbidden()
    {
        return View();
    }

    [HttpGet]
    public IActionResult ErrorPage()
    {
        return View();
    }
    public IActionResult Privacy()
    {
        return View();
    }
}
