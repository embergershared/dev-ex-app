using ContosoUniversity.API.Models;
using Microsoft.EntityFrameworkCore;

namespace ContosoUniversity.API.Data
{
    public class ContosoUniversityAPIContext : DbContext
    {
        public ContosoUniversityAPIContext (DbContextOptions<ContosoUniversityAPIContext> options) : base(options)
        {
        }

        public DbSet<Course> Courses { get; set; }
        public DbSet<Student> Students { get; set; }
        public DbSet<Department> Departments { get; set; }
        public DbSet<Instructor> Instructors { get; set; }
        public DbSet<StudentCourse> StudentCourse { get; set; }


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Course>().ToTable("tbl_Courses");
            modelBuilder.Entity<Student>().ToTable("tbl_Students");
            modelBuilder.Entity<Department>().ToTable("tbl_Departments");
            modelBuilder.Entity<Instructor>().ToTable("tbl_Instructors");
            modelBuilder.Entity<StudentCourse>().ToTable("tbl_StudentCourses");
            modelBuilder.Entity<StudentCourse>().HasKey(c => new { c.CourseID, c.StudentID });

            modelBuilder.Entity<StudentCourse>()
                .HasOne(bc => bc.Student)
                .WithMany(b => b.StudentCourse)
                .HasForeignKey(bc => bc.StudentID);

            modelBuilder.Entity<StudentCourse>()
                .HasOne(bc => bc.Course)
                .WithMany(c => c.StudentCourse)
                .HasForeignKey(bc => bc.CourseID);
        }
    }
}