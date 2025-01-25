using AutoMapper;
using Library.Contracts.DTOs;
using Library.Infrastructure;

namespace Library.Application.Mappings;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<User, UserDto>();
    }
}