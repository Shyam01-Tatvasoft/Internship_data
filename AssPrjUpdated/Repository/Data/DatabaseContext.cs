using Microsoft.EntityFrameworkCore;

namespace Repository.Data;

public partial class DatabaseContext : DbContext
{
    public DatabaseContext()
    {

    }

    public DatabaseContext(DbContextOptions<DatabaseContext> options)
        : base(options)
    { }

    public virtual DbSet<User> Users { get; set; }
    public virtual DbSet<Concerts> Concerts { get; set; }
    public virtual DbSet<Booking> Booking { get; set; }
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    => optionsBuilder.UseNpgsql("Host=localhost;Database=assessment_temp;Username=postgres;Password=Tatva@123");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<User>(entity =>
        {
            entity.HasIndex(e => e.Email).IsUnique();
            entity.Property(e => e.CreatedDate).HasDefaultValueSql("now()");
        });

        modelBuilder.Entity<Concerts>(entity =>
        {
            entity.Property(e => e.CreatedDate).HasDefaultValueSql("now()");
        });
        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}

