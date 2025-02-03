using AutoMapper;
using Library.Application.Commands.Users.Create;
using Library.Contracts.DTOs;
using Library.Domain.Models;

namespace Library.Application.Mappings;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<User, UserDto>();
        CreateMap<CreateUserCommand, User>()
            .ForMember(u => u.IsActive, 
                opt 
                    => opt.MapFrom(src => true));
        CreateMap<UserDto, UpdateUserDto>();
    }
}