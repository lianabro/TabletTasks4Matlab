

pathdefm

PsychTweak('UseGPUIndex', 1);
Screen('Preference', 'SkipSyncTests', 1);
% Screen('Preference','SyncTestSettings', 0.001 , 50, 0.1, 5);

% tsds (Touch Screen Double Step) in Matlab
% by Liana Brown - Jan 2019

warning('off','MATLAB:dispatcher:InexactMatch');
cd('C:\Users\liana\Dropbox\Research\Experiments\VMTasks');
%cd('C:\Documents and Settings\Administrator\Desktop\Andrew1\Program');
%addpath(pwd)
clear all;
sca;
%initialize eye tracker
%vpx_initialize;


clc;

sub = input('Enter subject number: ');
sex = input('Enter sex (0=M; 1=F): ');
cond = input('Enter cond (0 = Eu, 1 = D1, 2 = D2): ');
session = input('Enter session # (1-3): ');
block = input('Enter block# (0 for practice block, then 1): ');
if block == 0
    trials = 24; %input('Enter number of trials (48 for a full block): ');
elseif block > 0
    trials = 48;
end;
% trials = 1;

SOA = 250; %input('175 or 200 or 225 or 250: ');
SOA = SOA/1000;
mdata(1).SOA = SOA;
iti=1;
%date = input('Enter date (e.g. a *six-digit* value representing DMY = 211108): ');
crit=3;

%img=imread('circleg.gif', 'GIF');

rectime = .001;
disp(' ');

fs = 2^15; %Hz
ts=1/fs; Ws = 2*pi/ts;
%******************** timing variables ********************

time_display = 2.00; % should be 1 s. in expt. max target display time in s
timeb4jump = .075; % will be determined by eye movements during experiment

%******************* display variables *********************

%set up screen params
screenNum=0;
res = [3000 2000];
clrdepth = 32;


%center of screen;
centerX=res(1)/2;
centerY=res(2)/2;
NTx = 1059; %x value returned by GetMouse when screen is not being touched.
NTy = 1819; %y value returned by GetMouse when screen is not being touched.

% important positions
Oy=centerY; %1200;
Ox=round((1024-898)/1024*res(1));

h1=1000;
h2=1150;

a1=25; %20 degrees
a2=8; % 8 degrees
pix_cm = round(res(1)/28.6);

startX = Ox;
startY = Oy; %400

targ0X = Ox+10*pix_cm;
targ0Y = Oy;

targ1X = Ox+13*pix_cm;
targ1Y = Oy;

targ2X = Ox+16*pix_cm;
targ2Y = Oy;

targ3X = Ox+19*pix_cm;
targ3Y = Oy;

targ4X = Ox+22*pix_cm;
targ4Y = Oy;


disp('Hit any key to continue.');

data(1:trials,1:11)=0;

pause;


% set up arrays for design
for i=1:trials
    order(i) = 0;
end;
i=1;
%%%%%%%%%%%% Uses FUNCTIONS %%%%%%%%%%%%%%

% Balance: bal=BalancePC(hand_resp, hand_rest);
% pickTrial: [index,order] = pickTrial(order);

%%%%%%%%%% MAIN EXPERIMENT %%%%%%%%%%%%

% set up trial order
bal=BalancePC_DS(trials);


[wPtr,rect]=Screen('OpenWindow',screenNum,0,[0,0,res(1),res(2)],clrdepth);
black=BlackIndex(wPtr);
white=WhiteIndex(wPtr);
% textureIndex=Screen('MakeTexture', wPtr, double(img));
% Screen('DrawTexture', wPtr, textureIndex);
Screen('FillRect',wPtr,black);
Screen('TextSize', wPtr , 12); Screen('DrawText', wPtr, int2str(i), 25, 25, [100 100 100]);
vbl=Screen(wPtr, 'Flip'); % show plane you've been drawing on.

% if block == 0
%     Screen('TextSize', wPtr , 12);
%     Screen('DrawText', wPtr, ['After reading these instructions, a screen will appear that has a red dot near the   '], 15, 50, [255 0 0]);
%     Screen('DrawText', wPtr, ['bottom of the screen (closest to you). This dot is the starting location of each trial.   '], 15, 90, [255 0 0]);
%     Screen('DrawText', wPtr, 'To start, you must touch the red dot and you need to be looking at the red dot.     ', 15, 130, [255 0 0]);

%     Screen('DrawText', wPtr, 'Next, a target will appear on the screen. Once you see the target appear,  ', 15, 210, [255 0 0]);
%     Screen('DrawText', wPtr, 'it is your task to point to the target on screen as quickly as possible.  ', 15, 250, [255 0 0]);
%     Screen('DrawText', wPtr, 'The target will disappear after the trial is completed. At this point,  ', 15, 290, [255 0 0]);
%     Screen('DrawText', wPtr, 'please touch the starting dot to continue with the next trials. ', 15, 330, [255 0 0]);
%     Screen('DrawText', wPtr, 'During this experiment, we will be measuring and tracking your movements, so it’s important   ', 15, 370, [255 0 0]);
%     Screen('DrawText', wPtr, 'that you move quickly. Do you have any questions?', 15, 410, [255 0 0]);
%     Screen('DrawText', wPtr, 'Are you ready to begin the experiment? Press any key to continue. ', 15, 480, [255 0 0]);
%     vbl=Screen(wPtr, 'Flip'); % show plane you've been drawing on.
%     pause(2);
%     pause;
%     pause(2);
% end;

if block == 0
        Screen('TextSize', wPtr , 36);
        Screen('DrawText', wPtr, ['After reading these instructions, a screen will appear that has a red dot near the   '], 40, 50, [255 0 0]);
        Screen('DrawText', wPtr, ['bottom of the screen (closest to you). This dot is the starting location of each trial.   '], 40, 100, [255 0 0]);
        Screen('DrawText', wPtr, 'To start, you must touch the red dot and you need to be looking at the red dot.     ', 40, 150, [255 0 0]);
        
        Screen('DrawText', wPtr, 'Next, a target will appear on the screen. Once you see the target appear,  ', 40, 200, [255 0 0]);
        Screen('DrawText', wPtr, 'it is your task to point to the target on screen as quickly as possible.  ', 40, 250, [255 0 0]);
        Screen('DrawText', wPtr, 'The target will disappear after the trial is completed. At this point,  ', 40, 300, [255 0 0]);
        Screen('DrawText', wPtr, 'please touch the starting dot to continue with the next trials. ', 40, 350, [255 0 0]);
        Screen('DrawText', wPtr, 'During this experiment, we will be measuring and tracking your movements, so it’s important   ', 40, 400, [255 0 0]);
        Screen('DrawText', wPtr, 'that you move quickly. Do you have any questions?', 40, 450, [255 0 0]);
        Screen('DrawText', wPtr, 'Are you ready to begin the experiment? Press any key to continue. ', 40, 500, [255 0 0]);
end;

if block > 0

    Screen('TextSize', wPtr , 36);
    Screen('DrawText', wPtr, ['The instructions are the same as before. Ready? '], 400, 350, [255 255 255]);
    Screen('DrawText', wPtr, 'Press any key to continue.', 400, 950, [255 255 255]);
    vbl=Screen(wPtr, 'Flip'); % show plane you've been drawing on.
    pause(5);
end;


for i = 1:trials
    
    t1=0;
    t2=0;
    %choose which trial we are going to do right now.
    [index,order] = pickTrial(order);
    
    %choose the duration of the foreperiod. This foreperiod should probably
    %be long for this experiment since the subject needs time to move hand back to start position, shift hand
    %to new cue location and then look back.
    time_foreperiod = .5 + rand(1,1);
    
    
    
    % show the Fixation alone.
    targ=bal(index).targloc;
    %targ = 3;
    jump=bal(index).jumppres; %
    targ2=bal(index).jumptarg;
    mdata(i).targ = targ;
    
    
    
    
    %     no jumping in the practice block.
    if block == 0
        jump = 0;
    end;
    mdata(i).jump = jump;
    mdata(i).jumptarg = targ2;
    mdata(i).jumpdir = bal(index).jumpdir;
    
    tic;
    time(1) = toc;
    [xs(1),ys(1)] = GetMouse;
    d=0;
    
    % draw trial number in corner
    %         Screen('DrawTexture', wPtr, textureIndex);
    Screen('TextSize', wPtr , 40); Screen('DrawText', wPtr, int2str(i), 25, 25, [100 100 100]);
    
    Screen('FillOval',wPtr,[250 0 0],[(startX - pix_cm), (startY - pix_cm), (startX + pix_cm), (startY + pix_cm)]);
    % show start location
    vbl=Screen(wPtr, 'Flip'); % show start location and cue and start the clock
    
    % wait until finger lands inside the start location within 1 cm of
    % centre and then wait for variable foreperiod between .5-1.5 seconds
    % get this loop going;
    for ii=2:10;
        [xs(ii),ys(ii)] = GetMouse; time(ii) = toc;
        d=diff(xs);
        h(ii) = abs(xs(ii) - startX);
    end;
    
    
    %stay here until screen is touched... check for touch
    while xs(ii) < 200 || xs(ii) > 500 %&& h(ii) < pix_cm
        ii=ii+1; time(ii) = toc;
        [xs(ii),ys(ii)] = GetMouse;
    end;
    
    %when touch happens, record start time
    iT0RT = [time(ii),xs(ii),ys(ii)];
    %
    % make P wait on start until variable foreperiod is over
    
    while time(ii)-iT0RT < time_foreperiod;
        ii=ii+1;time(ii) = toc;
    end;
    
    %variable foreperiod is over... record time and show target.
    clear d ii xs ys;
    %reset clock
    tic;
    a1 = toc;
    flag = 0;
    ii=1;
    d=1;
    while a1 < 3
        a1 = toc;
        %NO JUMP TRIALS
        if jump == 0; % there is no jump present
            
            Screen('FillOval',wPtr,[250 0 0],[(startX - pix_cm), (startY - pix_cm), (startX + pix_cm), (startY + pix_cm)]);
            
            if targ == 2
                Screen('FillOval',wPtr,[100 100 100],[(targ1X - pix_cm), (targ1Y - pix_cm), (targ1X + pix_cm), (targ1Y + pix_cm)]);
                tx(i) = targ1X;
            end;
            if targ == 3
                Screen('FillOval',wPtr, [100 100 100],[(targ2X - pix_cm), (targ2Y - pix_cm), (targ2X + pix_cm), (targ2Y + pix_cm)]);
                tx(i) = targ2X;
            end
            if targ == 4
                Screen('FillOval',wPtr, [100 100 100],[(targ3X - pix_cm), (targ3Y - pix_cm), (targ3X + pix_cm), (targ3Y + pix_cm)]);
                tx(i) = targ3X;
            end;
            vbl=Screen(wPtr, 'Flip');  % show target and start clock
            
            t2x(i) = tx(i);
            lmit=t2x(i)-500;
            
            %time and detect lift off
            ii=ii+1;
            [xs(ii),ys(ii)] = GetMouse; time(ii) = toc;
            d=diff(ys);
            
            if flag == 1 && xs(ii) > lmit
                TouchTime(i) = time(ii);
                respX(i) = xs(ii);
                respY(i) = ys(ii);
                MT(i) = (TouchTime(i)*1000) - RT(i);
                flag = 0;
                break;
            end;
            
            %record RT
            if abs(d(ii-1)) ~= 0; % if finger has lifted, record RT
                RT(i) = time(ii)*1000; %when finger leaves start position, RT is recorded.
                t2 =time(ii);
                flag = 1;
            end;
        end;
        
        % JUMP TRIALS
        if jump == 1; % there is a jump present
            
            if a1 <= .250
                
                Screen('FillOval',wPtr,[250 0 0],[(startX - pix_cm), (startY - pix_cm), (startX + pix_cm), (startY + pix_cm)]);
                
                if targ == 2
                    Screen('FillOval',wPtr,[100 100 100],[(targ1X - pix_cm), (targ1Y - pix_cm), (targ1X + pix_cm), (targ1Y + pix_cm)]);
                    tx(i) = targ1X;
                end;
                if targ == 3
                    Screen('FillOval',wPtr, [100 100 100],[(targ2X - pix_cm), (targ2Y - pix_cm), (targ2X + pix_cm), (targ2Y + pix_cm)]);
                    tx(i) = targ2X;
                end;
                if targ == 4
                    Screen('FillOval',wPtr, [100 100 100],[(targ3X - pix_cm), (targ3Y - pix_cm), (targ3X + pix_cm), (targ3Y + pix_cm)]);
                    tx(i) = targ3X;
                end;
                lmit=tx(i)-600;   
                vbl=Screen(wPtr, 'Flip');  % show target and start clock
            end;
                      
            if a1 > .250 %SOA
                          % show new one
                
                Screen('FillOval',wPtr,[250 0 0],[(startX - pix_cm), (startY - pix_cm), (startX + pix_cm), (startY + pix_cm)]);
                if targ2 == 1
                    Screen('FillOval',wPtr, [100 100 100],[(targ0X - pix_cm), (targ0Y - pix_cm), (targ0X + pix_cm), (targ0Y + pix_cm)]);
                    t2x(i) = targ0X;
                end;
                if targ2 == 2
                    Screen('FillOval',wPtr, [100 100 100],[(targ1X - pix_cm), (targ1Y - pix_cm), (targ1X + pix_cm), (targ1Y + pix_cm)]);
                    t2x(i) = targ1X;
                end;
                if targ2 == 3
                    Screen('FillOval',wPtr, [100 100 100],[(targ2X - pix_cm), (targ2Y - pix_cm), (targ2X + pix_cm), (targ2Y + pix_cm)]);
                    t2x(i) = targ2X;
                end;
                if targ2 == 4
                    Screen('FillOval',wPtr, [100 100 100],[(targ3X - pix_cm), (targ3Y - pix_cm), (targ3X + pix_cm), (targ3Y + pix_cm)]);
                    t2x(i) = targ3X;
                end;
                if targ2 == 5
                    Screen('FillOval',wPtr, [100 100 100],[(targ4X - pix_cm), (targ4Y - pix_cm), (targ4X + pix_cm), (targ4Y + pix_cm)]);
                    t2x(i) = targ4X;
                end;
                lmit=t2x(i)-600;          
                vbl=Screen(wPtr, 'Flip');  % show target and start clock
            end;

                       
            %record time of finger lift off
            ii=ii+1;
            [xs(ii),ys(ii)] = GetMouse; time(ii) = toc;
            d=diff(ys);
            
            if flag == 1 && xs(ii) > lmit;
                TouchTime(i) = time(ii);
                respX(i) = xs(ii);
                respY(i) = ys(ii);
                MT(i) = (TouchTime(i)*1000) - RT(i);
                flag = 0;
                break;
            end;
            
            
            %record RT
            if abs(d(ii-1)) ~= 0; % if finger has lifted, record RT
                RT(i) = time(ii)*1000; %when finger leaves start position, RT is recorded.
                t2 =time(ii);
                flag = 1;
             end;
        end;
    end;
    
    % Cut that display off
    Screen('FillRect',wPtr,black);
    vbl=Screen(wPtr, 'Flip');
    
    %record MT and touch error
    errX(i) = (respX(i) - t2x(i))/pix_cm*10; %in cm
    errY(i) = (respY(i) - Oy)/pix_cm*10; %in cm
    pause(iti); %1 second
    
    %clear y4;
    data(i,1) = sub;
    data(i,2) = sex;
    data(i,3) = cond;
    data(i,4) = session;
    data(i,5) = block;
    data(i,6) = i;
    data(i,7) = jump;
    data(i,8) = targ;
    data(i,9) = targ2;
    data(i,10) = t2x(i);
    data(i,11) = RT(i);
    data(i,12)= MT(i);
    data(i,13)= respX(i);
    data(i,14)= respY(i);
    data(i,15)= errX(i);
    data(i,16)= errY(i);
    
    clear ii;
         clear d;
         clear h;
         clear xs;
         clear ys;
    
    
end;
%pause


%******************** save Data *********************

mdata(1).sub = sub; %subject number
mdata(1).sex = sex; %sex
%mdata(1).hand = hand; %hand absent (0) or present (1)
mdata(1).block = block; % block number
%     data(i,10)= t2;% EM time from tic toc




sca;

cd('C:\Users\liana\Dropbox\Research\Experiments\VMTasks\dataDS');
fn = CatStr(['s', int2str(sub),'_b', int2str(block),'_sess', int2str(session),'_DS.mat']);
fn1 = CatStr(['s', int2str(sub),'_b', int2str(block),'_sess', int2str(session),'_DS.txt']);
eval(['save ', fn, ' mdata']);
fsave(data,fn1);
eval('cd ..');

disp('Data Saved');
disp('This part of the experiment is over. Please alert the experimenter!');

