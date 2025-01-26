using Library.Contracts.DTOs;
using Library.Contracts.Exceptions;
using Library.Contracts.Responses;
using Library.Infrastructure;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Library.Application.Commands.Users.Delete;

public class DeleteUserCommandHandler : IRequestHandler<DeleteUserCommand, Response>
{
    private readonly LibraryDbContext _context;

    public DeleteUserCommandHandler(LibraryDbContext dbContext)
    {
        _context = dbContext;
    }

    public async Task<Response> Handle(DeleteUserCommand request, CancellationToken cancellationToken)
    {
        var canDelete = await CanUserBeDeleted(request);

        if (!canDelete)
            return Response.Fail("User does not exist", 404);

        var userToDelete = await _context.Users.FirstOrDefaultAsync(u => u.Id == request.Id, cancellationToken);

        if (userToDelete is null)
            return Response.Fail("User not found");

        userToDelete.IsActive = false;
        _context.Users.Update(userToDelete);
        await _context.SaveChangesAsync(cancellationToken);

        return Response.Success();
    }

    private async Task<bool> CanUserBeDeleted(DeleteUserCommand request)
    {
        var hasOutstandingCheckouts = await _context
            .Checkouts.AnyAsync(c => c.UserId == request.Id && c.ReturnedDate == null);
        var hasUnpaidFees = await _context.Fees.AnyAsync(f => f.UserId == request.Id && !f.Paid);

        return !hasOutstandingCheckouts && !hasUnpaidFees;
    }
}