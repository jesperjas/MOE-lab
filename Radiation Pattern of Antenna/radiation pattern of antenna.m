1   closeall;
 2   clc;
 3   % Constants
 4   c=3e8; % Speed of light (m/s)
 5   
6   % Input Parameters
 7   frequency=10e9; % Frequency (Hz)
 8   wavelength=c/frequency; % Wavelength (m)
 9   horn_width=0.1; % Width of the horn aperture (m)
 10   horn_height=0.08; % Height of the horn aperture (m)
 11   theta=linspace(-90,90,1000); % Angle in degrees
 12   
13   % Calculate the far-field pattern
 14   kx=(2*pi/wavelength)*horn_width*sind(theta);
 15   ky=(2*pi/wavelength)*horn_height*sind(theta);
 16   
17   % Electric field pattern (simplified for a rectangular aperture)
 18   E_theta=sinc(kx/pi).*sinc(ky/pi);
 19   E_theta=abs(E_theta).^2; % Power pattern
 20   
21   % Normalize the pattern
 22   E_theta_dB=10*log10(E_theta/max(E_theta));
 23   
24   % Plot the radiation pattern
 25   figure;
 26   plot(theta,E_theta_dB);
 27   title('Radiation Pattern of Horn Antenna');
 28   xlabel('Theta (degrees)');
 29   ylabel('Normalized Power (dB)');
 30   gridon;
 31   
32   % Calculate HPBW (Half-Power Beamwidth)
 33   half_power_points=find(E_theta_dB>=-3);
 34   HPBW=theta(half_power_points(end))-theta(half_power_points(1));
 35   fprintf('Half-Power Beamwidth (HPBW): %.2f degrees\n',HPBW);
 36   
37   % Calculate FNBW (First Null Beamwidth)
 38   nulls=find(diff(signbit(E_theta_dB)));
 39   FNBW=theta(nulls(2))-theta(nulls(1));
 40   fprintf('First Null Beamwidth (FNBW): %.2f degrees\n',FNBW);
 41   
42   % Calculate SLL (Side Lobe Level)
 43   main_lobe_max=max(E_theta_dB);
 44   side_lobes=E_theta_dB(nulls(2):end);
 45   SLL=max(side_lobes);
 46   fprintf('Side Lobe Level (SLL): %.2f dB\n',SLL);
 47   