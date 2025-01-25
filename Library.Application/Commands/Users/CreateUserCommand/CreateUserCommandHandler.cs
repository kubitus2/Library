using Library.Infrastructure;
using MediatR;

namespace Library.Application.Commands.Users.CreateUserCommand;

public class CreateUserCommandHandler : IRequestHandler<CreateUserCommand, int>
{
    private readonly LibraryDbContext _context;

    public CreateUserCommandHandler(LibraryDbContext context)
    {
        _context = context;
    }
    public async Task<int> Handle(CreateUserCommand request, CancellationToken cancellationToken)
    {
        var user = new User
        {
            FirstName = request.FirstName,
            LastName = request.LastName,
            Email = request.Email,
            Phone = request.PhoneNumber,
            IsBlocked = false
        };
        
        await _context.Users.AddAsync(user, cancellationToken);
        await _context.SaveChangesAsync(cancellationToken);
        return user.Id;
    }
}