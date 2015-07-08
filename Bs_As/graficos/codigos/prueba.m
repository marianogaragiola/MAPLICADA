%Set up dates
years = [2001; 2001; 2002; 2002; 2003; 2003];
months = [1 7 1 7 1 7];
days = ones(1,6);

for k = 1:6
  dates(k) = datenum(years(k), months(k), days(k));
end

%Plot Data
plot(dates, 100 + 20*rand(1,6), 'o')

%Set Ticks
labels = datestr(dates, 20);
set(gca, 'XTick', dates);
set(gca, 'XTickLabel', labels);

%Label Axes and Set Title
xlabel('Date')
ylabel('Sales')
title('Example of Date Axis')
