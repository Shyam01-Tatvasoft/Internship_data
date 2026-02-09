using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Repository.Interface;
using Repository.ViewModels;
using Service.Interfaces;

namespace Web.Controllers;

[Authorize(Roles = "Admin")]
public class AdminController : Controller
{
    private readonly IConcertService _concertService;
    public AdminController(IConcertService concertService)
    {
        _concertService = concertService;
    }

    [HttpGet]
    public async Task<IActionResult> Index()
    {
        AdminPageViewModel model = new AdminPageViewModel();
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
        AdminPageViewModel model = new AdminPageViewModel();
        try
        {
            List<ConcertViewModel> concertList = await _concertService.GetConcerts(searchString, artistName, startDate, endDate, venueType, venueBy);
            model.ConcertList = concertList;
            return PartialView("_ConcertList", model);
        }
        catch (System.Exception)
        {
            return View(model);
        }

    }

    [HttpGet]
    public async Task<IActionResult> AddEditConcert(int? id)
    {

        try
        {
            if (id == null)
            {
                return PartialView("_AddEditConcert", new AddEditConcertViewModel());
            }
            else
            {
                AddEditConcertViewModel model = await _concertService.GetConcertbyId((int)id);
                return PartialView("_AddEditConcert", model);
            }
        }
        catch (System.Exception)
        {
            return Json(new { success = false, message = "Error While fetching data" });
        }
    }

    [HttpPost]
    public async Task<IActionResult> AddEditConcert(AddEditConcertViewModel model)
    {
        if (!ModelState.IsValid)
        {
            return Json(new { isValid = false, message = "Fill required field" });
        }
        try
        {
            if (model.Id == null || model.Id == 0)
            {
                await _concertService.AddConcert(model);
                return Json(new { success = true, message = "Concert added successfully" });
            }
            else
            {
                await _concertService.EditConcert(model);
                return Json(new { success = true, message = "Concert updated successfully" });
            }
        }
        catch (System.Exception)
        {
            return Json(new { success = false, message = "Error" });
        }
    }

    [HttpPost]
    public async Task<IActionResult> DeleteConcert(int id)
    {
        try
        {
            await _concertService.DeleteConcert(id);
            return Json(new { success = true, message = "Concert deleted successfully" });
        }
        catch (System.Exception)
        {

            return Json(new { success = false, message = "Error" });
        }
    }

    [HttpGet]
    public async Task<IActionResult> Bookings()
    {
        try
        {
            List<BookingViewModel> model = await _concertService.GetBookings();
            return View(model);
        }
        catch (System.Exception)
        {
            return View(new List<BookingViewModel>());
        }
    }
}
