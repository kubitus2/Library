using Microsoft.AspNetCore.Mvc;

namespace Library.Presentation.Controllers;

[Route("Error")]
public class ErrorController : Controller
{
    [Route("404")]
    public IActionResult Error404()
    {
        return View("404");
    }

    [Route("400")]
    public IActionResult Error400()
    {
        return View("400");
    }

    [Route("500")]
    public IActionResult Error500()
    {
        return View("500");
    }
}