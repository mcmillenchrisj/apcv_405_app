# Use the official .NET SDK image for build and test
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copy solution and project files
COPY apcv_405_app.sln ./
COPY ClassProjectApp/ClassProjectApp.csproj ClassProjectApp/
COPY ClassProjectApp.Tests/ClassProjectApp.Tests.csproj ClassProjectApp.Tests/

# Restore dependencies for the solution
RUN dotnet restore apcv_405_app.sln

# Copy the rest of the source code
COPY . .

# Build the solution
RUN dotnet build apcv_405_app.sln -c Release

# Run tests
RUN dotnet test ClassProjectApp.Tests/ClassProjectApp.Tests.csproj -c Release --no-build --logger:trx

# Publish the main project
RUN dotnet publish ClassProjectApp/ClassProjectApp.csproj -c Release -o /app/publish --no-build

# Use the official ASP.NET runtime image for the final stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final

WORKDIR /app
COPY --from=build /app/publish .

# Expose port 9090
EXPOSE 9090

# Run the application
ENTRYPOINT ["dotnet", "ClassProjectApp.dll"]