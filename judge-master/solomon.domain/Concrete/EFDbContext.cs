using Solomon.Domain.Entities;
using Solomon.TypesExtensions;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;

namespace Solomon.Domain.Concrete
{
    public class EFDbContext : DbContext
    {
        public DbSet<Comment> Comments { get; set; }
        public DbSet<UserProfile> UserProfiles { get; set; }
        public DbSet<Team> Teams { get; set; }
        public DbSet<UserProfileTeam> UserProfileTeam { get; set; }
        public DbSet<Tournament> Tournaments { get; set; }
        public DbSet<TournamentFormat> TournamentFormats { get; set; }
        public DbSet<TournamentType> TournamentTypes { get; set; }
        public DbSet<Problem> Problems { get; set; }
        public DbSet<ProblemTag> ProblemTags { get; set; }
        public DbSet<ProblemType> ProblemTypes { get; set; }
        public DbSet<Solution> Solutions { get; set; }
        public DbSet<TestResult> TestResults { get; set; }
        public DbSet<SolutionTestResult> SolutionTestResults { get; set; }
        public DbSet<ProgrammingLanguage> ProgrammingLanguages { get; set; }
        public DbSet<Country> Country { get; set; }
        public DbSet<City> City { get; set; }
        public DbSet<Institution> Institutions { get; set; }
        public DbSet<UserCategory> UserCategories { get; set; }

        protected override void OnModelCreating(DbModelBuilder mb)
        {
            // Prevents table names from being pluralized.
            mb.Conventions.Remove<PluralizingTableNameConvention>();

            mb.Entity<SolutionTestResult>().HasRequired(str => str.TestResult).WithMany().WillCascadeOnDelete(false);

            mb.Entity<Problem>().HasMany(p => p.Tournaments).WithMany(t => t.Problems).Map(m => m.ToTable("ProblemTournament"));

            mb.Entity<Tournament>().HasMany(p => p.Users).WithMany(t => t.Tournaments).Map(m => m.ToTable("UserProfileTournament"));
            mb.Entity<UserProfileTeam>().HasMany(p => p.Tournaments).WithMany(t => t.Teams).Map(m => m.ToTable("UserProfileTeamTournament"));




            //modelBuilder.Entity<UserProfile>().HasMany<Team>(t => t.Teams).WithMany(u => u.Members).Map(
            //    x =>
            //    {
            //        x.ToTable("UserProfileTeam", "public");
            //    }
            //);
        }

    }

    public class EFDbContextInitializer : CreateDatabaseIfNotExists<EFDbContext>
    {
        protected override void Seed(EFDbContext context)
        {
            IList<ProgrammingLanguage> defaultLanguages = new List<ProgrammingLanguage>();

            defaultLanguages.Add(new ProgrammingLanguage
            {
                ProgrammingLanguageID = ProgrammingLanguages.C,
                Title = "GNU C"
            });
            defaultLanguages.Add(new ProgrammingLanguage
            {
                ProgrammingLanguageID = ProgrammingLanguages.CPP,
                Title = "GNU C++"
            });
            defaultLanguages.Add(new ProgrammingLanguage
            {
                ProgrammingLanguageID = ProgrammingLanguages.CS,
                Title = "C# .NET"
            });
            defaultLanguages.Add(new ProgrammingLanguage
            {
                ProgrammingLanguageID = ProgrammingLanguages.VB,
                Title = "VB .NET"
            });
            defaultLanguages.Add(new ProgrammingLanguage
            {
                ProgrammingLanguageID = ProgrammingLanguages.Java,
                Title = "Java"
            });
            defaultLanguages.Add(new ProgrammingLanguage
            {
                ProgrammingLanguageID = ProgrammingLanguages.Pascal,
                Title = "Free Pascal"
            });
            defaultLanguages.Add(new ProgrammingLanguage
            {
                ProgrammingLanguageID = ProgrammingLanguages.Python,
                Title = "Python"
            });

            foreach (var std in defaultLanguages)
                context.ProgrammingLanguages.Add(std);

            context.UserCategories.Add(new UserCategory {UserCategoryID = UserCategories.None, Name = "Не выбрано"});
            context.UserCategories.Add(new UserCategory {UserCategoryID = UserCategories.School, Name = "Школьник"});
            context.UserCategories.Add(new UserCategory {UserCategoryID = UserCategories.Student, Name = "Студент"});
            context.UserCategories.Add(new UserCategory
            {
                UserCategoryID = UserCategories.Teacher,
                Name = "Преподаватель"
            });
            context.UserCategories.Add(new UserCategory {UserCategoryID = UserCategories.Other, Name = "Другое"});


            context.TournamentTypes.Add(
                new TournamentType {TournamentTypeID = TournamentTypes.Open, Name = "Открытый"});
            context.TournamentTypes.Add(
                new TournamentType {TournamentTypeID = TournamentTypes.Close, Name = "Закрытый"});

            context.TournamentFormats.Add(new TournamentFormat
            {
                TournamentFormatID = TournamentFormats.ACM,
                Name = "ACM (Проверка до первого неверного ответа, штрафное время за посылки)"
            });
            context.TournamentFormats.Add(new TournamentFormat
            {
                TournamentFormatID = TournamentFormats.IOI,
                Name = "IOI (Проверка на всех тестах, без штрафных очков)"
            });

            context.ProblemTypes.Add(new ProblemType
            {
                ProblemTypeID = ProblemTypes.Interactive,
                Name = "Интерактивная"
            });
            context.ProblemTypes.Add(new ProblemType
            {
                ProblemTypeID = ProblemTypes.Open,
                Name = "Открытая задача (только ответ на задачу)"
            });
            context.ProblemTypes.Add(new ProblemType
            {
                ProblemTypeID = ProblemTypes.Standart,
                Name = "Стандартная задача (стандартные потоки ввода/вывода)"
            });

            context.TestResults.Add(new TestResult {TestResultID = TestResults.CE, Name = "CE"});
            context.TestResults.Add(new TestResult {TestResultID = TestResults.CHKP, Name = "CHKP"});
            context.TestResults.Add(new TestResult {TestResultID = TestResults.Compiling, Name = "Compiling"});
            context.TestResults.Add(new TestResult {TestResultID = TestResults.Disqualified, Name = "Disqualified"});
            context.TestResults.Add(new TestResult {TestResultID = TestResults.Executing, Name = "Executing"});
            context.TestResults.Add(new TestResult {TestResultID = TestResults.FL, Name = "FL"});
            context.TestResults.Add(new TestResult {TestResultID = TestResults.MLE, Name = "MLE"});
            context.TestResults.Add(new TestResult {TestResultID = TestResults.OK, Name = "OK"});
            context.TestResults.Add(new TestResult {TestResultID = TestResults.PE, Name = "PE"});
            context.TestResults.Add(new TestResult {TestResultID = TestResults.PS, Name = "PS"});
            context.TestResults.Add(new TestResult {TestResultID = TestResults.Waiting, Name = "Waiting"});
            context.TestResults.Add(new TestResult {TestResultID = TestResults.TLE, Name = "TLE"});
            context.TestResults.Add(new TestResult {TestResultID = TestResults.RTE, Name = "RTE"});
            context.TestResults.Add(new TestResult {TestResultID = TestResults.WA, Name = "WA"});

            context.ProblemTags.Add(new ProblemTag {ProblemTagID = 0, Name = "Ввод вывод данных"});
            context.ProblemTags.Add(new ProblemTag {ProblemTagID = 1, Name = "Условный оператор"});
            context.ProblemTags.Add(new ProblemTag {ProblemTagID = 2, Name = "Циклы"});
            context.ProblemTags.Add(new ProblemTag {ProblemTagID = 3, Name = "Массивы"});
            context.ProblemTags.Add(new ProblemTag {ProblemTagID = 4, Name = "Строки"});
            context.ProblemTags.Add(new ProblemTag {ProblemTagID = 5, Name = "Функции"});
            context.ProblemTags.Add(new ProblemTag {ProblemTagID = 6, Name = "Рекурсия"});
            context.ProblemTags.Add(new ProblemTag {ProblemTagID = 7, Name = "Динамика"});
            context.ProblemTags.Add(new ProblemTag {ProblemTagID = 8, Name = "Бинарный поиск"});

            //All standards will
            base.Seed(context);
        }
    }
}
