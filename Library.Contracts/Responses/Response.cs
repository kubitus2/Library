namespace Library.Contracts.Responses;

public class Response
{
    public bool Succeeded { get; set; }
    public string? Message { get; set; }
    public int StatusCode { get; set; }

    public static Response Success()
    {
        return new Response { Succeeded = true, StatusCode = 200 };
    }

    public static Response Fail(string message, int code = 500)
    {
        return new Response { Succeeded = false, Message = message, StatusCode = code };
    }
}

public class Response<T> : Response
{
    public T? Data { get; set; }

    public static Response<T> Success(T data)
    {
        return new Response<T> { Succeeded = true, Data = data, StatusCode = 200 };
    }

    public static Response<T> Fail(string message, int code = 500)
    {
        return new Response<T> { Succeeded = false, Message = message, StatusCode = code };
    }
}