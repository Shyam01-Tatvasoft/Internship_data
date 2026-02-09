using Microsoft.EntityFrameworkCore;
namespace app.Data;

public partial class DatabaseContext : DbContext
{
    public DatabaseContext()
    {

    }
    public DatabaseContext(DbContextOptions<DatabaseContext> options)
        : base(options)
    { }

    public virtual DbSet<User> UsersTable { get; set; }
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    => optionsBuilder.UseNpgsql("Host=localhost;Database=user_auth;Username=postgres;Password=Tatva@123");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<User>(entity =>
        {
            entity.HasIndex(e => e.Email).IsUnique();
            entity.Property(e => e.CreatedDate).HasDefaultValueSql("now()");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
