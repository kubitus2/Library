using Library.Contracts.Exceptions;
using Library.Contracts.Responses;
using Library.Infrastructure;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Library.Application.Commands.Users.Update;

public class UpdateUserCommandHandler : IRequestHandler<Update.UpdateUserCommand, Response>
{
    private readonly LibraryDbContext _context;

    public UpdateUserCommandHandler(LibraryDbContext context)
    {
        _context = context;
    }
    
    public async Task<Response> Handle(Update.UpdateUserCommand request, CancellationToken cancellationToken)
    {
        var userToUpdate = await _context.Users.FirstOrDefaultAsync(u => u.Id == request.Id);

        if (userToUpdate is null)
            return Response.Fail("Not found", 404);

        userToUpdate.FirstName = request.FirstName;
        userToUpdate.LastName = request.LastName;
        userToUpdate.Email = request.Email;
        userToUpdate.Phone = request.Phone;
        
        _context.Users.Update(userToUpdate);
        await _context.SaveChangesAsync(cancellationToken);
        
        return Response.Success();
    }
}