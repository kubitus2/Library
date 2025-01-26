using AutoMapper;
using Library.Infrastructure;
using MediatR;

namespace Library.Application.Commands.Users.Create;

public class CreateUserCommandHandler : IRequestHandler<Create.CreateUserCommand, int>
{
    private readonly LibraryDbContext _context;
    private readonly IMapper _mapper;

    public CreateUserCommandHandler(LibraryDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<int> Handle(Create.CreateUserCommand request, CancellationToken cancellationToken)
    {
        var user = _mapper.Map<User>(request);
        user.IsActive = true;

        await _context.Users.AddAsync(user, cancellationToken);
        await _context.SaveChangesAsync(cancellationToken);
        return user.Id;
    }
}