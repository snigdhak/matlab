function sigma0_CT_exact = gsw_sigma0_CT_exact(SA,CT)

% gsw_sigma0_CT_exact                        potential density anomaly with
%                                         reference sea pressure of 0 dbar.
%==========================================================================
% 
% USAGE:  
%  sigma0_CT_exact = gsw_sigma0_CT_exact(SA,CT)
%
% DESCRIPTION:
%  Calculates potential density anomaly with reference pressure of 0 dbar,
%  this being this particular potential density minus 1000 kg/m^3.  This
%  function has inputs of Absolute Salinity and Conservative Temperature.
%
%  Note that this function uses the full Gibbs function.  There is an 
%  alternative to calling this function, namely gsw_sigma0(SA,CT,p), 
%  which uses the computationally efficient 48-term expression for density 
%  in terms of SA, CT and p (IOC et al., 2010).   
%
% INPUT:
%  SA  =  Absolute Salinity                                        [ g/kg ]
%  CT  =  Conservative Temperature (ITS-90)                       [ deg C ]
%
%  SA & CT need to have the same dimensions.
%
% OUTPUT:
%  sigma0_CT_exact  =  potential density anomaly with            [ kg/m^3 ]
%                      respect to a reference pressure of 0 dbar,   
%                      that is, this potential density - 1000 kg/m^3.
%
% AUTHOR: 
%  Trevor McDougall & Paul Barker                      [ help@teos-10.org ]
%
% VERSION NUMBER: 3.03 (29th April, 2013)
%
% REFERENCES:
%  IOC, SCOR and IAPSO, 2010: The international thermodynamic equation of 
%   seawater - 2010: Calculation and use of thermodynamic properties.  
%   Intergovernmental Oceanographic Commission, Manuals and Guides No. 56,
%   UNESCO (English), 196 pp.  Available from http://www.TEOS-10.org
%    See Eqn. (A.30.1) of this TEOS-10 Manual. 
%
%  The software is available from http://www.TEOS-10.org
%
%==========================================================================

%--------------------------------------------------------------------------
% Check variables and resize if necessary
%--------------------------------------------------------------------------

if ~(nargin == 2)
   error('gsw_sigma0_CT_exact:  Requires two inputs')
end %if

[ms,ns] = size(SA);
[mt,nt] = size(CT);

if (mt ~= ms | nt ~= ns)
    error('gsw_sigma0_CT_exact: SA and CT must have same dimensions')
end

if ms == 1
    SA = SA.';
    CT = CT.';
    transposed = 1;
else
    transposed = 0;
end

%--------------------------------------------------------------------------
% Start of the calculation
%--------------------------------------------------------------------------

pt0 = gsw_pt_from_CT(SA,CT);
sigma0_CT_exact = gsw_sigma0_pt0_exact(SA,pt0);

if transposed
    sigma0_CT_exact = sigma0_CT_exact.';
end

% The output, being potential density anomaly, has units of kg/m^3 and is 
% potential density with 1000 kg/m^3 subtracted from it. 

end