using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace Library.Infrastructure;

public partial class LibraryDbContext : DbContext
{
    public LibraryDbContext()
    {
    }

    public LibraryDbContext(DbContextOptions<LibraryDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Address> Addresses { get; set; }

    public virtual DbSet<Author> Authors { get; set; }

    public virtual DbSet<AvailabilityStatus> AvailabilityStatuses { get; set; }

    public virtual DbSet<Book> Books { get; set; }

    public virtual DbSet<BookCopy> BookCopies { get; set; }

    public virtual DbSet<Checkout> Checkouts { get; set; }

    public virtual DbSet<Fee> Fees { get; set; }

    public virtual DbSet<FeeType> FeeTypes { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderDetail> OrderDetails { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Address>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__address__3213E83FD768320C");

            entity.ToTable("address");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.BuildingNumber)
                .HasMaxLength(255)
                .HasColumnName("buildingNumber");
            entity.Property(e => e.City)
                .HasMaxLength(255)
                .HasColumnName("city");
            entity.Property(e => e.FlatNumber)
                .HasMaxLength(255)
                .HasColumnName("flatNumber");
            entity.Property(e => e.PostalCode)
                .HasMaxLength(255)
                .HasColumnName("postalCode");
            entity.Property(e => e.Street)
                .HasMaxLength(255)
                .HasColumnName("street");
        });

        modelBuilder.Entity<Author>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__author__3213E83F274E3A76");

            entity.ToTable("author");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.FirstName)
                .HasMaxLength(255)
                .HasColumnName("firstName");
            entity.Property(e => e.LastName)
                .HasMaxLength(255)
                .HasColumnName("lastName");

            entity.HasMany(d => d.Books).WithMany(p => p.Authors)
                .UsingEntity<Dictionary<string, object>>(
                    "BookAuthor",
                    r => r.HasOne<Book>().WithMany()
                        .HasForeignKey("BookId")
                        .HasConstraintName("FK_BookAuthor_Book"),
                    l => l.HasOne<Author>().WithMany()
                        .HasForeignKey("AuthorId")
                        .HasConstraintName("FK_BookAuthor_Author"),
                    j =>
                    {
                        j.HasKey("AuthorId", "BookId").HasName("PK_BookAuthor");
                        j.ToTable("bookAuthor");
                        j.IndexerProperty<int>("AuthorId").HasColumnName("author_id");
                        j.IndexerProperty<int>("BookId").HasColumnName("book_id");
                    });
        });

        modelBuilder.Entity<AvailabilityStatus>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__availabi__3213E83F6E1423EB");

            entity.ToTable("availabilityStatus");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("id");
            entity.Property(e => e.Type)
                .HasMaxLength(255)
                .HasColumnName("type");
        });

        modelBuilder.Entity<Book>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__book__3213E83F7633BEB1");

            entity.ToTable("book");

            entity.HasIndex(e => e.Isbn, "UQ__book__447D36EA52EC7A4D").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Genre)
                .HasMaxLength(255)
                .HasColumnName("genre");
            entity.Property(e => e.IsAvailableForSale)
                .HasDefaultValue(false)
                .HasColumnName("isAvailableForSale");
            entity.Property(e => e.Isbn)
                .HasMaxLength(255)
                .HasColumnName("ISBN");
            entity.Property(e => e.Price)
                .HasDefaultValue(0m)
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("price");
            entity.Property(e => e.PublishedYear).HasColumnName("publishedYear");
            entity.Property(e => e.Title)
                .HasMaxLength(255)
                .HasColumnName("title");
        });

        modelBuilder.Entity<BookCopy>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__bookCopy__3213E83FC430E512");

            entity.ToTable("bookCopy");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Availability).HasColumnName("availability");
            entity.Property(e => e.BookId).HasColumnName("book_id");

            entity.HasOne(d => d.AvailabilityNavigation).WithMany(p => p.BookCopies)
                .HasForeignKey(d => d.Availability)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__bookCopy__availa__6FE99F9F");

            entity.HasOne(d => d.Book).WithMany(p => p.BookCopies)
                .HasForeignKey(d => d.BookId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__bookCopy__book_i__6EF57B66");
        });

        modelBuilder.Entity<Checkout>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__checkout__3213E83F68F6C921");

            entity.ToTable("checkout");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.BookCopyId).HasColumnName("bookCopyId");
            entity.Property(e => e.BorrowDate).HasColumnName("borrowDate");
            entity.Property(e => e.OverdueFee)
                .HasDefaultValue(0m)
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("overdueFee");
            entity.Property(e => e.ReturnedDate)
                .HasDefaultValueSql("(NULL)")
                .HasColumnName("returnedDate");
            entity.Property(e => e.UserId).HasColumnName("userId");

            entity.HasOne(d => d.BookCopy).WithMany(p => p.Checkouts)
                .HasForeignKey(d => d.BookCopyId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__checkout__bookId__70DDC3D8");

            entity.HasOne(d => d.User).WithMany(p => p.Checkouts)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__checkout__userId__71D1E811");
        });

        modelBuilder.Entity<Fee>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__fee__3213E83F8A4EC680");

            entity.ToTable("fee");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Amount)
                .HasColumnType("decimal(18, 0)")
                .HasColumnName("amount");
            entity.Property(e => e.CheckoutId).HasColumnName("checkoutId");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .HasColumnName("description");
            entity.Property(e => e.Paid).HasColumnName("paid")
                .HasDefaultValue(false);
            entity.Property(e => e.FeeType).HasColumnName("feeType");
            entity.Property(e => e.UserId).HasColumnName("userId");

            entity.HasOne(d => d.Checkout).WithMany(p => p.Fees)
                .HasForeignKey(d => d.CheckoutId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__fee__checkoutId__74AE54BC");

            entity.HasOne(d => d.FeeTypeNavigation).WithMany(p => p.Fees)
                .HasForeignKey(d => d.FeeType)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__fee__feeType__75A278F5");

            entity.HasOne(d => d.User).WithMany(p => p.Fees)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__fee__userId__76969D2E");
        });

        modelBuilder.Entity<FeeType>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__feeType__3213E83F10DB1EB7");

            entity.ToTable("feeType");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("id");
            entity.Property(e => e.Type)
                .HasMaxLength(255)
                .HasColumnName("type");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__order__3213E83FB436A3B1");

            entity.ToTable("order");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.AddressId).HasColumnName("addressId");
            entity.Property(e => e.OrderDate).HasColumnName("orderDate");
            entity.Property(e => e.UserId).HasColumnName("userId");

            entity.HasOne(d => d.Address).WithMany(p => p.Orders)
                .HasForeignKey(d => d.AddressId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__order__addressId__73BA3083");

            entity.HasOne(d => d.User).WithMany(p => p.Orders)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__order__userId__72C60C4A");
        });

        modelBuilder.Entity<OrderDetail>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__orderDet__3213E83FB28E1AB6");

            entity.ToTable("orderDetails");

            entity.HasIndex(e => new { e.BookCopyId, e.OrderId }, "UQ_OrderDetails").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.BookCopyId).HasColumnName("bookCopyId");
            entity.Property(e => e.OrderId).HasColumnName("orderId");

            entity.HasOne(d => d.BookCopy).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.BookCopyId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK_OrderDetails_BookCopy");

            entity.HasOne(d => d.Order).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.OrderId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK_OrderDetails_Order");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__user__3213E83FBD3F3691");

            entity.ToTable("user");

            entity.HasIndex(e => e.Email, "UQ__user__AB6E6164FDD0914C").IsUnique();

            entity.HasIndex(e => e.Phone, "UQ__user__B43B145FD8339BD3").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Email)
                .HasMaxLength(255)
                .HasColumnName("email");
            entity.Property(e => e.FirstName)
                .HasMaxLength(255)
                .HasColumnName("firstName");
            entity.Property(e => e.IsBlocked)
                .HasDefaultValue(false)
                .HasColumnName("isBlocked");
            entity.Property(e => e.LastName)
                .HasMaxLength(255)
                .HasColumnName("lastName");
            entity.Property(e => e.Phone)
                .HasMaxLength(255)
                .HasColumnName("phone");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
