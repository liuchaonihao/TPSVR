
figID = figure('Color',[1 1 1]);
hold on; 
plot(Pre,'-r+');
plot(temp4,'-b.');
plot(temp4-Pre,'-gx');
legend('Prediction','Original','error')

xlim([0 length(Pre)]);
box on;
xlabel('Time(min)');
ylabel('Windpower');
grid on;

