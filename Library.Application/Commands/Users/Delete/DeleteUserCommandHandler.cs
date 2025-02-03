using Library.Contracts.Responses;
using Library.Domain.Repositories;
using MediatR;

namespace Library.Application.Commands.Users.Delete;

public class DeleteUserCommandHandler : IRequestHandler<DeleteUserCommand, Response>
{
    private readonly IUserRepository _repository;
    private readonly IUnitOfWork _unitOfWork;

    public DeleteUserCommandHandler(IUserRepository repository, IUnitOfWork unitOfWork)
    {
        _repository = repository;
        _unitOfWork = unitOfWork;
    }

    public async Task<Response> Handle(DeleteUserCommand request, CancellationToken cancellationToken)
    {
        var userToDelete = await _repository.GetById(request.Id, cancellationToken);

        if (userToDelete is null)
            return Response.Fail("User not found", 404);
        var canDelete = await _repository.CanBeDeleted(userToDelete, cancellationToken);
        if (!canDelete)
            return Response.Fail("User cannot be removed", 400);

        _repository.Delete(userToDelete);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        return Response.Success();
    }
}