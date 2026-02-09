using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace app.Migrations
{
    /// <inheritdoc />
    public partial class fifthMigration : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_User",
                table: "User");

            migrationBuilder.RenameTable(
                name: "User",
                newName: "UsersTable");

            migrationBuilder.RenameIndex(
                name: "IX_User_Email",
                table: "UsersTable",
                newName: "IX_UsersTable_Email");

            migrationBuilder.AddPrimaryKey(
                name: "PK_UsersTable",
                table: "UsersTable",
                column: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_UsersTable",
                table: "UsersTable");

            migrationBuilder.RenameTable(
                name: "UsersTable",
                newName: "User");

            migrationBuilder.RenameIndex(
                name: "IX_UsersTable_Email",
                table: "User",
                newName: "IX_User_Email");

            migrationBuilder.AddPrimaryKey(
                name: "PK_User",
                table: "User",
                column: "Id");
        }
    }
}
