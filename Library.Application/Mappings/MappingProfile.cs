using System.Security.Cryptography;
using AutoMapper;
using Library.Application.Commands.Users.Create;
using Library.Contracts.DTOs;
using Library.Contracts.Responses;
using Library.Infrastructure;

namespace Library.Application.Mappings;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<User, UserDto>();
        CreateMap<CreateUserCommand, User>();
        CreateMap<UserDto, UpdateUserDto>();
    }
}