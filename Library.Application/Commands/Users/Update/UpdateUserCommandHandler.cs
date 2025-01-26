using Library.Infrastructure;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Library.Application.Commands.Users.UpdateUserCommand;

public class UpdateUserCommandHandler : IRequestHandler<UpdateUserCommand, Unit>
{
    private readonly LibraryDbContext _context;

    public UpdateUserCommandHandler(LibraryDbContext context)
    {
        _context = context;
    }
    
    public async Task<Unit> Handle(UpdateUserCommand request, CancellationToken cancellationToken)
    {
        var userToUpdate = await _context.Users.FirstOrDefaultAsync(u => u.Id == request.Id);

        if (userToUpdate is null)
            throw new Exception();

        userToUpdate.FirstName = request.FirstName;
        userToUpdate.LastName = request.LastName;
        userToUpdate.Email = request.Email;
        userToUpdate.Phone = request.Phone;
        
        _context.Users.Update(userToUpdate);
        await _context.SaveChangesAsync(cancellationToken);
        
        return Unit.Value;
    }
}