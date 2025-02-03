using AutoMapper;
using Library.Domain.Models;
using Library.Domain.Repositories;
using Library.Infrastructure;
using Library.Models;
using MediatR;

namespace Library.Application.Commands.Users.Create;

public class CreateUserCommandHandler : IRequestHandler<Create.CreateUserCommand, int>
{
    private readonly LibraryDbContext _context;
    private readonly IUserRepository _repository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly IMapper _mapper;

    public CreateUserCommandHandler(LibraryDbContext context, IMapper mapper, IUserRepository repository, IUnitOfWork unitOfWork)
    {
        _context = context;
        _mapper = mapper;
        _repository = repository;
        _unitOfWork = unitOfWork;
    }

    public async Task<int> Handle(Create.CreateUserCommand request, CancellationToken cancellationToken)
    {
        var user = _mapper.Map<User>(request);
        user.IsActive = true;

        await _repository.Add(user, cancellationToken);
        await _unitOfWork.SaveChangesAsync(cancellationToken);
        return user.Id;
    }
}