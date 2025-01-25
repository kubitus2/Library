using AutoMapper;
using Library.Contracts.DTOs;
using Library.Contracts.Responses;
using Library.Infrastructure;

namespace Library.Application.Mappings;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<User, UserDto>()
            .ForMember(dest => dest.Name, opt
                => opt.MapFrom(src => $"{src.FirstName} {src.LastName}"));
        CreateMap<List<User>, GetUsersResponse>()
            .ConvertUsing(src 
                => new GetUsersResponse(src.Select(user => new UserDto(user.Id, $"{user.FirstName} {user.LastName}", user.Email)).ToList()));
    }
}