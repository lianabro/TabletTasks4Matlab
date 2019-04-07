% intercept in Matlab

% a program in which the participant needs to intercept a target that moves
% from left to right at one of three different speeds and with acceleration
% or not.

pathdefm;

PsychTweak('UseGPUIndex', 1);
Screen('Preference', 'SkipSyncTests', 1);

warning('off','MATLAB:dispatcher:InexactMatch');
cd('C:\Users\liana\Dropbox\Research\Experiments\VMTasks');
%cd('C:\Documents and Settings\Administrator\Desktop\Andrew1\Program');
%addpath(pwd)
clear;
sca;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%start motion tracker%%%%%%%%%%%%%%%%%%%%%
% a = date;
% fcal = catstr(['cal_',a,'.txt']);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
sub = input('Enter subject number: ');
sex = input('Enter sex (0=M; 1=F): ');
cond = input('Enter cond (0 = Eu, 1 = D1, 2 = D2): ');
session = input('Enter session# (1-3): ');
block = input('Enter block# (0 for practice block, then 1): ');

trials = 60;
if block == 0
    trials = 18; %switch to 6 for testing program
end;

rectime = .001;
disp(' ');
disp('Hit any key to continue.');

pause;
%******************** timing variables ********************

time_display = 2.00; % should be 1 s. in expt. max target display time in s
timeb4jump = .075; % will be determined by eye movements during experiment

%******************* display variables *********************

%set up screen params
screenNum=0;
res = [3000 2000];
clrdepth = 32;
pix_cm = round(res(1)/28.6);

%center of screen;
centerX=res(1)/2;
centerY=res(2)/2;

leftX = round(.05*res(1));
leftY= centerY;

rightX = round(.90*res(1));
rightY = centerY;

% important positions
startX = leftX;
startY = centerY;
targX = rightX;
targY = centerY;
handyX = targX;
handyY = centerY + 8*pix_cm; %8 cm below centre
ht=50;

% set up arrays for design
order(1:trials)=0;
i=1;




%%%%%%%%%%%% Uses FUNCTIONS %%%%%%%%%%%%%%

% Balance: bal=BalancePC(hand_resp, hand_rest);
% pickTrial: [index,order] = pickTrial(order);

%%%%%%%%%% MAIN EXPERIMENT %%%%%%%%%%%%

% set up trial order
bal=BalancePC_I(trials);

[wPtr,rect]=Screen('OpenWindow',screenNum); %,0,[0,0,res(1),res(2)],clrdepth);
black=BlackIndex(wPtr);
white=WhiteIndex(wPtr);
Screen('FillRect',wPtr,black);
Screen('TextSize', wPtr , 60); Screen('DrawText', wPtr, int2str(i), 25, 25, [66 66 66]);
vbl=Screen(wPtr, 'Flip'); % show plane you've been drawing on.

%show instructions
if block == 0
    keyIsDown = 0;
    [ keyIsDown, seconds1, keyCode ] = KbCheck;
    while keyIsDown == 0 % if button is not being pressed, begin
    Screen('TextSize', wPtr , 36);
    Screen('DrawText', wPtr, ['A black screen will appear with a blue square near the bottom right corner. To start a   '], 50, 90, [255 0 0]);
    Screen('DrawText', wPtr, ['trial, double tap the blue square. Next, a green target will appear on   '], 50,130, [255 0 0]);
    Screen('DrawText', wPtr, 'the left side of the screen. It will move across the screen from left to right. Your      ', 50, 170, [255 0 0]);
    Screen('DrawText', wPtr, 'task is to intercept the target by "hitting" it with your finger as it passes through     ', 50, 210, [255 0 0]);
    Screen('DrawText', wPtr, 'the white crosshairs. You can only intercept it as it passes through the crosshairs,      ', 50, 250, [255 0 0]);
    Screen('DrawText', wPtr, 'not earlier or later. Do you understand?                                                  ', 50, 290, [255 0 0]);
    Screen('DrawText', wPtr, 'We will let you know whether you hit or missed the target. It is important that you move  ', 50, 370, [255 0 0]);
    Screen('DrawText', wPtr, 'quickly so that you can intercept as many targets as possible. Do you have any questions? ', 50, 450, [255 0 0]);
    Screen('DrawText', wPtr, 'Are you ready to begin the experiment? Press any key to continue.                      ', 50, 540, [255 0 0]);
    vbl=Screen(wPtr, 'Flip'); % show plane you've been drawing on.
    [ keyIsDown, seconds, keyCode ] = KbCheck;
    end;
end;

if block == 1
    keyIsDown = 0;
    [ keyIsDown, seconds1, keyCode ] = KbCheck;
    while keyIsDown == 0 % if button is not being pressed, begin
    Screen('TextSize', wPtr , 36);
    Screen('DrawText', wPtr, ['The instructions are the same as before. Ready? '], 400, 350, [255 255 255]);
    Screen('DrawText', wPtr, 'Press any key to continue.', 400, 950, [255 255 255]);
    vbl=Screen(wPtr, 'Flip'); % show plane you've been drawing on.
    [ keyIsDown, seconds, keyCode ] = KbCheck;
    end;
end;


% Set up Fish
fishTarg=imread('happy_gold_fish1.png');
textureIndex1=Screen('MakeTexture' ,wPtr, double(fishTarg));
[fy,fx,fz] = size(fishTarg);


fishHit=imread('Hit1.png');
textureIndex2=Screen('MakeTexture' ,wPtr, double(fishHit));
[fhy,fhx,fhz] = size(fishHit);

fishMiss=imread('happy_gold_fish1.png');
textureIndex3=Screen('MakeTexture' ,wPtr, double(fishMiss));
[fmy,fmx,fmz] = size(fishMiss);

% 
% img1=imread('X.x.4.jpg');
% textureIndex1=Screen('MakeTexture', wPtr, double(img1));
% fn = catstr(['textureIndex', int2str(targnum(i))]);
% eval(['Screen(''DrawTexture'', wPtr, ', fn,');']);   



for i = 1:trials
    [index,order] = pickTrial(order);
    
    %choose the duration of the foreperiod. This foreperiod should probably
    %be long for this experiment since the subject needs time to move hand back to start position, shift hand
    %to new cue location and then look back.
    time_foreperiod = 1 + rand(1,1);
    
    % show the Fixation alone.
    if bal(index).vel == 1
        vel(i)=.02; %20 cm/s
    elseif bal(index).vel == 2
        vel(i)=.05; %30 cm/s
    elseif bal(index).vel == 3
        vel(i)=.08; %40 cm/s
    end;
    
    %vel(i)=pix2cm*25; %25 cm/s
    acc(i)=bal(index).accel;
%     if acc(i) == 1
%         acc(i) == 0; % 1 m/s/s
%     end;
%     acc(i) = 0;
    b=0;

    % show initial display
    %draw trial number in corner
    Screen('TextSize', wPtr , 60); Screen('DrawText', wPtr, int2str(i), 25, 25, [66 66 66]);
    
    %draw interception zone crosshairs
    Screen('DrawLine', wPtr, white, rightX-ht, centerY, rightX+ht, centerY, 5);
    Screen('DrawLine', wPtr, white, rightX, centerY-ht, rightX, centerY+ht, 5);
    
    % show target in start location still
    %Screen('FillOval',wPtr,[0 250 0],[(leftX - 2*ht), (startY - ht), (leftX + 2*ht), (startY + ht)]);
    Screen('DrawTexture', wPtr, textureIndex1,[],[(leftX - round(fx/2)), (startY - round(fy/2)), (leftX + round(fx/2)), (startY + round(fy/2))]);
    
    %show finger start location
    Screen('FillRect',wPtr,[0 0 250],[(handyX - ht), (handyY - ht), (handyX + ht), (handyY + ht)]);
    vbl=Screen(wPtr, 'Flip'); % show start location and cue
    
    % is the start being touched?
    % start clock
    ii=1;
    tic;
    time(ii) = toc;
    [xs(1),ys(1)] = GetMouse;
    d=0;
    
    %set up 'no touch' situation
    for ii=2:10;
        [xs(ii),ys(ii)] = GetMouse; time(ii) = toc;
        d=diff(ys);
        h(ii) = abs(ys(ii) - startY);
    end;  
    
    %stay here until screen is touched... check for touch
    while abs(d(ii-1)) < 200 & h(ii) < pix_cm
        ii=ii+1; time(ii) = toc;
        [xs(ii),ys(ii)] = GetMouse;
        d=diff(ys);
        h(ii) = abs(ys(ii) - startY);
    end;
    
    %P has touched the start box. Restart the clock and monitor foreperiod.
    ii=ii+1;
    tic;
    time(ii) = toc;
    
    while time(ii) < time_foreperiod
        %what time is it?
        time(ii)=toc;
        
        %draw trial number in corner
        Screen('TextSize', wPtr , 60); Screen('DrawText', wPtr, int2str(i), 25, 25, [66 66 66]);
        
        %draw interception zone crosshairs
        Screen('DrawLine', wPtr, white, rightX-ht, centerY, rightX+ht, centerY, 5);
        Screen('DrawLine', wPtr, white, rightX, centerY-ht, rightX, centerY+ht, 5);
        
        % show target in start location still
        Screen('DrawTexture', wPtr, textureIndex1,[],[(leftX - round(fx/2)), (startY - round(fy/2)), (leftX + round(fx/2)), (startY + round(fy/2))]);
        
        %show finger start location
        Screen('FillRect',wPtr,[0 0 250],[(handyX - ht), (handyY - ht), (handyX + ht), (handyY + ht)]);
        vbl=Screen(wPtr, 'Flip'); % show start location and cue
        
    end;
    %foreperiod is over, let's go!
    
    %reset clock
    flag = 0;
    n=1;
    ii=0;
    ii=ii+1;
    tic;
    a1 = toc;
    xpos(n) = startX;
    while a1 < 3
         %draw trial number in corner
        Screen('TextSize', wPtr , 60); Screen('DrawText', wPtr, int2str(i), 25, 25, [66 66 66]);
        
        %draw interception zone crosshairs
        Screen('DrawLine', wPtr, white, rightX-ht, centerY, rightX+ht, centerY, 5);
        Screen('DrawLine', wPtr, white, rightX, centerY-ht, rightX, centerY+ht, 5);

        a1=toc; time(ii) = a1; mdata(n,1)=a1; 
        n=n+1; ii=ii+1;
        t(n)=a1*1000; %how much time has passed in milliseconds?
        xpos(n) = acc(i)*t(n)*t(n) + vel(i)*t(n) + xpos(n-1); %new position = accel*tsquared + vel*t + last position
       

        Screen('DrawTexture', wPtr, textureIndex1,[],[(xpos(n) - round(fx/2)), (startY - round(fy/2)), (xpos(n) + round(fx/2)), (startY + round(fy/2))]);
        
        mdata(n,2)=xpos(n);
      
        %show finger start location
        Screen('FillRect',wPtr,[0 0 250],[(handyX - ht), (handyY - ht), (handyX + ht), (handyY + ht)]);       
        vbl=Screen(wPtr, 'Flip'); % show start location and cue
        
        %record time of finger lift off
        ii=ii+1;
        [xs(ii),ys(ii)] = GetMouse; time(ii) = toc;
        d=diff(ys);
        
        if flag == 1 && abs(d(ii-1)) > 200
            TouchTime(i) = time(ii);
            TouchLocX(i) = xs(ii);
            TouchLocY(i) = ys(ii);
            TargLoc(i) = xpos(n-1);
            deltaTouchLocX(i) = TargLoc(i) - TouchLocX(i)
            deltaTouchLocY(i) = TouchLocY(i) - centerY;
            MT(i) = (TouchTime(i)*1000) - RT(i);
            flag = 0;
        end;
            
        %record RT
        if abs(d(ii-1)) > 200; % if finger has lifted, record RT
            RT(i) = time(ii)*1000; %when finger leaves start position, RT is recorded.
            t2 =time(ii);
            flag = 1;
        end;
        if xpos(n) > res(1)+1000;
            break;
        end;
     end;

     %pause(1);
%%% uncomment     
    % want to know - when did target get to the interception zone?
    for v=1:length(xpos)
        if xpos(v) > (rightX-ht)
            xposTime(i)=mdata(v,1)*1000; % time when target reached target location
            deltaTouchTime(i) = xposTime(i) - TouchTime(i)*1000;
            break;
        end;
    end;
 
    if abs(deltaTouchLocX(i)) < 125
        judge(i) = 1; %HIT! show dead fish for 1.5 seconds
        Screen('TextSize', wPtr , 96); Screen('DrawText', wPtr, 'HIT!', centerX-100, centerY+100, [0 250 0]);
        Screen('DrawTexture', wPtr, textureIndex2,[],[(centerX - round(fhx/2)), (startY - round(fhy/2)), (centerX + round(fhx/2)), (startY + round(fhy/2))]);
        
        vbl=Screen(wPtr, 'Flip'); % show plane you've been drawing on.
        pause(1);
    else
        judge(i) = 0; %MISS% show smiley fish
        Screen('TextSize', wPtr , 96); Screen('DrawText', wPtr, 'MISS!', centerX-100, centerY+100, [250 0 0]);
        Screen('DrawTexture', wPtr, textureIndex3,[],[(centerX - round(fmx/2)), (startY - round(fmy/2)), (centerX + round(fmx/2)), (startY + round(fmy/2))]);
        vbl=Screen(wPtr, 'Flip'); % show plane you've been drawing on.
        pause(1);
   end;
%     
    b=0;
    tic;
    % get ready for next trial
    while toc < 1
        Screen('FillRect',wPtr,black);
        %Cut that display off
        vbl=Screen(wPtr, 'Flip'); % show plane you've been drawing on.
    end;
    
%     %Cut that display off
%     Screen('FillRect',wPtr,black);
%     vbl=Screen(wPtr, 'Flip'); % show plane you've been drawing on.
    
    
    data(1).sub=sub;;
    data(1).sex = sex;
    data(1).block = block;
    data(1).session = session;
    data(1).condition = cond;
    data(i).vel = vel(i); % targ number
    data(i).accel = acc(i); %trial number
    data(i).time = time;
    data(i).targ = xpos; %where was hand it crossed Y line (target path)
    data(i).RT= RT(i); %what time did hand cross Y line (target path)
    data(i).MT = MT(i); %what time did fish reach intercept location
    data(i).TTime = TouchTime(i); %where was hand (in pixels) when fish reached intercept location
    data(i).TLocX = TouchLocX(i); %where was hand (in pixels) when fish reached intercept location
    data(i).TLocY = TouchLocY(i); %where was hand (in pixels) when fish reached intercept location
    data(i).TargLocT = TargLoc(i);
    data(i).dTLX = deltaTouchLocX(i);
    data(i).dTLY = deltaTouchLocY(i);
    data(i).judge = judge(i); % hit or miss?
    data(i).XposTime = xposTime(i);
    data(i).dTT = deltaTouchTime(i); % +errors = hand is late
    %data(i).xpos;
clear mdata adata;
    
    
    sdata(i,1) = sub;
    sdata(i,2) = sex;
    sdata(i,3) = cond;
    sdata(i,4) = block;
    sdata(i,5) = session;
    sdata(i,6) = i;
    sdata(i,7) = acc(i);
    sdata(i,8) = vel(i);
    sdata(i,9) = xposTime(i); %viewing time
    sdata(i,10) = judge(i)
    sdata(i,11) = deltaTouchTime(i);
    sdata(i,12) = deltaTouchLocX(i);
    clear xpos d;
end;

sca;

%save data
cd('C:\Users\liana\Dropbox\Research\Experiments\VMTasks\dataI');
fn = CatStr(['s', int2str(sub),'_b', int2str(block), '_sess', int2str(session), 'int.mat']);
eval(['save ', fn, ' data']);
fn2 = CatStr(['s', int2str(sub),'_b', int2str(block), '_sess', int2str(session),'int.txt']);
fsave(sdata,fn2);
eval('cd ..');

disp('Data Saved');
disp('This part of the experiment is over. Please alert the experimenter!');
























