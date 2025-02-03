using Library.Application.Helpers;
using Library.Contracts.Responses;
using Library.Domain.Models;
using Library.Domain.Repositories;
using Library.Infrastructure;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;

namespace Library.Application.Commands.Users.Update;

public class UpdateUserCommandHandler : IRequestHandler<Update.UpdateUserCommand, Response>
{
    private readonly LibraryDbContext _context;
    private readonly IUnitOfWork _unitOfWork;
    private readonly IUserRepository _repository;

    public UpdateUserCommandHandler(LibraryDbContext context, IUnitOfWork unitOfWork, IUserRepository repository)
    {
        _context = context;
        _unitOfWork = unitOfWork;
        _repository = repository;
    }

    public async Task<Response> Handle(UpdateUserCommand request, CancellationToken cancellationToken)
    {
        var userToUpdate = await _repository.GetById(request.Id, cancellationToken);

        if (userToUpdate is null)
            return Response.Fail("Not found", 404);

        User updatedUser = new UserBuilder()
            .Copy(userToUpdate)
            .WithFirstName(request.FirstName)
            .WithLastName(request.LastName)
            .WithEmail(request.Email)
            .WithPhone(request.Phone);

        _repository.Update(updatedUser);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        return Response.Success();
    }
}