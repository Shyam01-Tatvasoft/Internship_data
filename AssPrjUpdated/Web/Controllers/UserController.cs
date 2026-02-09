using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Repository.ViewModels;
using Service.Interfaces;

namespace Web.Controllers;

[Authorize(Roles = "User")]
public class UserController : Controller
{
    private readonly IConcertService _concertService;

    public UserController(IConcertService concertService)
    {
        _concertService = concertService;
    }



    public async Task<IActionResult> Index()
    {
        UserPageViewModel model = new UserPageViewModel();
        try
        {
            List<ConcertViewModel> concertList = await _concertService.GetConcerts(null, null, null, null, null, null);
            model.ConcertList = concertList;
            return View(model);
        }
        catch (System.Exception)
        {
            return View(model);
        }
    }



    [HttpGet]
    public async Task<IActionResult> GetConcerts(string? searchString, string? artistName, DateTime? startDate, DateTime? endDate, string? venueType, string? venueBy)
    {
        UserPageViewModel model = new UserPageViewModel();
        try
        {
            List<ConcertViewModel> concertList = await _concertService.GetConcerts(searchString, artistName, startDate, endDate, venueType, venueBy);
            model.ConcertList = concertList;
            return PartialView("_UserConcertList", model);
        }
        catch (System.Exception)
        {
            return View(model);
        }

    }

    [HttpPost]
    public async Task<IActionResult> AddBooking(BookConcertViewModel model)
    {
        if (!ModelState.IsValid)
        {
            return Json(new { isValid = false, message = "Fill required field" });
        }
        try
        {
            await _concertService.AddBooking(model);
            return Json(new { success = true, message = "Concert Booked successfully" });
        }
        catch (System.Exception)
        {
            return View(model);
        }
    }
}
