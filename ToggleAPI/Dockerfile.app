#Do not use sdk3
FROM mcr.microsoft.com/dotnet/core/sdk:2.1
WORKDIR /app/ToggleAPI
COPY ./ToggleAPI ./

#App start
CMD ["dotnet" , "run"]