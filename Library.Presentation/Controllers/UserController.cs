using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Library.Application.Commands.Users.Create;
using Library.Application.Commands.Users.Delete;
using Library.Application.Commands.Users.Update;
using Library.Application.Queries.Users;
using Library.Application.Queries.Users.GetUserById;
using Library.Contracts.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Library.Infrastructure;
using MediatR;
using Microsoft.CodeAnalysis.Elfie.Serialization;

namespace Library.Presentation.Controllers
{
    public class UserController : Controller
    {
        private readonly LibraryDbContext _context;
        private readonly IMediator _mediator;
        private readonly IMapper _mapper;

        public UserController(LibraryDbContext context, IMediator mediator, IMapper mapper)
        {
            _context = context;
            _mediator = mediator;
            _mapper = mapper;
        }

        public async Task<IActionResult> Index()
        {
            var users = await _mediator.Send(new GetUsersQuery());
            return View(users.Data);
        }

        public async Task<IActionResult> Details(int id)
        {
            var response = await _mediator.Send(new GetUserByIdQuery(id));

            if (!response.Succeeded)
                return NotFound(response.Message);

            return View(response.Data);
        }

        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,FirstName,LastName,Email,Phone")] CreateUserDto user)
        {
            if (!ModelState.IsValid)
                return View(user);

            var response = await _mediator.Send(new CreateUserCommand(user));

            return RedirectToAction(nameof(Index));
        }

        public async Task<IActionResult> Edit(int id)
        {
            var response = await _mediator.Send(new GetUserByIdQuery(id));
            if (!response.Succeeded)
                return NotFound();
            
            return View(_mapper.Map<UpdateUserDto>(response.Data));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,FirstName,LastName,Email,Phone")] UpdateUserDto user)
        {
            if (!ModelState.IsValid)
                return View(user);
            
            await _mediator.Send(new UpdateUserCommand(user));

            return RedirectToAction(nameof(Index));
        }

        public async Task<IActionResult> Delete(int id)
        {
            var user = await _context.Users
                .FirstOrDefaultAsync(m => m.Id == id);
            if (user == null)
            {
                return NotFound();
            }

            return View(user);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var response = await _mediator.Send(new DeleteUserCommand(id));
            if (!response.Succeeded)
                return BadRequest(response.Message);
            
            return RedirectToAction(nameof(Index));
        }
    }
}