namespace Service.Interfaces;

public interface IJWTService
{
    public Task<string> GenerateToken(string email);
    public (string?, string?, string?) ValidateToken(string token);
}
