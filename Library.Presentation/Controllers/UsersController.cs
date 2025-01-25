using Library.Application.Queries.Users;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace Library.Presentation.Controllers;

public class UsersController : Controller
{
    private readonly ILogger<HomeController> _logger;
    private readonly IMediator _mediator;

    public UsersController(ILogger<HomeController> logger, IMediator mediator)
    {
        _logger = logger;
        _mediator = mediator;
    }

    public async Task<IActionResult> Index(CancellationToken token)
    {
        var users = await _mediator.Send(new GetUsersQuery(), token);
        return View(users);
    }
}