%getting the user to set the parameters
prompt = 'Please enter the angle to the horizontal (in degrees) which you want to shoot at: ';
theta = input(prompt);
prompt2 = 'Please enter the initial speed you would like to use: ';
u = input(prompt2);
g = 9.81; %acceleration due to gravity
q = 120; %arbitrary boundary limit
teta = 0:360; %angle for plotting the circle

%Defining the basket
x_basket_min = 80;
x_basket_max = 100;
x_basket = [x_basket_min, x_basket_max];
y_b = [50, 50];

%defining the second basket
x_basket_2_min = x_basket_min + 2*(q - x_basket_min);
x_basket_2_max = x_basket_max + 2*(q - x_basket_max);

%making the plot fullscreen
figure('units','normalized','outerposition',[0 0 1 1])

dim = [.4 .5 .4 .4]; %dimensions of the congratulations box

for k = 1:220
    % Getting the values of the centre of the circle
    X = k;
    Y = X*tand(theta) - g*(X^2)/(2*(u^2)*(cosd(theta)^2));
    r = 4; %radius of the ball
    
    % Clear the axes.
    cla
    
    % creating the circle
    x = X + r*cosd(teta);
    y = Y + r*sind(teta);
    
   
    %checking to see whether a basket has been scored
    if (x_basket_min <= X-r) && (X+r <= x_basket_max) && (y_b(1) - 5 <= Y-r) && (Y+r <= y_b(2) + 5)
        str = 'SCORE!!!!!!! CONGRATULATIONS ON MAKING THE SHOT';
        annotation('textbox',dim,'String',str,'FitBoxToText','on');
        %fprintf('SCORE!!!!!!! CONGRATULATIONS ON MAKING THE SHOT \n')
        return
    %elif check to see whether the ball is off the screen
    elseif (Y <= 0) && (X > 0)
        str = 'Unlucky... Try again by running the program';
        annotation('textbox',dim,'String',str,'FitBoxToText','on');
        return
    elseif ((x_basket_2_max <= X-r) && (X+r <= x_basket_2_min) && (y_b(1) - 5 <= Y-r) && (Y+r <= y_b(2) + 5)) %SCORING ON THE RIGHT SIDE OF THE SCREEN
        str = 'SCORE!!!!!!! CONGRATULATIONS ON MAKING THE REBOUND SHOT';
        annotation('textbox',dim,'String',str,'FitBoxToText','on');
        %fprintf('SCORE!!!!!!! CONGRATULATIONS ON MAKING THE REBOUND SHOT \n')
        return
        
    elseif (X >= q) %off the right side of the screen
        x_reb = (X - 2*(X - q)) + r*cosd(teta);
        fill(x_reb,y,'r')
        hold on
        plot(x_basket,y_b,'k','LineWidth',2)
        
        %fprintf('Unlucky... Try again by running the program \n')
        %return
    else
        %normal condition
        % Display the circles.
        %viscircles(app.UIAxes,centers,radii,'Color',[0 0 1]);
        fill(x,y,'r')
        hold on
        plot(x_basket,y_b,'k','LineWidth',2)
        end

        %Fixing the axis limits and making the axis square
        xlim([0 q])
        ylim([0 q])
        axis square

        % Pause for 1 second.
        pause(0.015)
end