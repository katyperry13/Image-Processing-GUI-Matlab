function y = isind(x)
%ISIND Return true for indexed image.
%   FLAG = ISIND(A) returns 1 if A is an indexed image and 0
%   otherwise. 
%
%   ISIND uses these criteria to determine if A is an indexed
%   image:
%
%   - If A is of class double, all values in A must be integers
%     greater than or equal to 1, and the number of dimensions of
%     A must be 2.
%
%   - If A is of class uint8, its logical flag must be off, and
%     the number of dimensions of A must be 2.
%
%   Note that a four-dimensional array that contains multiple
%   indexed images returns 0, not 1.
%
%   Class Support
%   -------------
%   A can be of class uint8 or double.
%
%   See also ISBW, ISGRAY, ISRGB.

%   Clay M. Thompson 2-25-93
%   revised by Chris Griffin 6-96
%   Copyright 1993-1998 The MathWorks, Inc.  All Rights Reserved.
%   $Revision: 5.9 $  $Date: 1997/11/24 15:35:49 $


y = ndims(x)==2;           % Check number of dimensions
if isa(x, 'uint8') & y
   if islogical(x)         % It's a binary image
      y = 0;
   end
elseif y   % The image is double and ndims==2
   % At first just test a small chunk to get a possible quick negative
   [m,n] = size(x);
   chunk = x(1:min(m,10),1:min(n,10));         
   y = min(chunk(:))>=1 & all((chunk(:)-floor(chunk(:)))==0);
   % If the chunk is an indexed image, test the whole image
   if y
      y = min(x(:))>=1 & all((x(:)-floor(x(:)))==0);
   end
end   
    

y = logical(y);
