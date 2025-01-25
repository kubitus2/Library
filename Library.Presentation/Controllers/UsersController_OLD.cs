using Library.Application.Queries.Users;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace Library.Presentation.Controllers;

public class UsersController_OLD : Controller
{
    private readonly ILogger<HomeController> _logger;
    private readonly IMediator _mediator;

    public UsersController_OLD(ILogger<HomeController> logger, IMediator mediator)
    {
        _logger = logger;
        _mediator = mediator;
    }

    public async Task<IActionResult> Index(CancellationToken token)
    {
        var users = await _mediator.Send(new GetUsersQuery(), token);
        return View(users);
    }

    public async Task<IActionResult> Create(CancellationToken token)
    {
        return View();
    }
}