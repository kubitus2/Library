using Library.Contracts.Responses;
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

    public async Task<Response> Handle(Update.UpdateUserCommand request, CancellationToken cancellationToken)
    {
        var userToUpdate = await _repository.GetById(request.Id, cancellationToken);

        if (userToUpdate is null)
            return Response.Fail("Not found", 404);

        userToUpdate.FirstName = request.FirstName;
        userToUpdate.LastName = request.LastName;
        userToUpdate.Email = request.Email;
        userToUpdate.Phone = request.Phone;

        _repository.Update(userToUpdate);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        return Response.Success();
    }
}