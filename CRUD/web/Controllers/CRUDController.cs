using Microsoft.AspNetCore.Mvc;
using repository.ViewModel;

namespace web.Controllers;

public class CRUDController : Controller
{
  public CRUDController()
  {

  }

  public IActionResult Index()
  {
    return View();
  }

  public IActionResult Add()
  {
    FormViewModel model = new FormViewModel();

    return PartialView("_Form", model);
  }

  [HttpPost]
  public IActionResult Add(FormViewModel model)
  {
    return View();
  }
}
