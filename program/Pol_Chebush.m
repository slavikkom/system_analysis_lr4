function  result = Pol_Chebush(d,x)

switch d
    case 0
        result = 0.5;
    case 1
        result = x;
    case 2
        result = 2 * x .^ 2 - 1;
    otherwise
        result = 2 * x .* Pol_Chebush( d - 1 , x ) - Pol_Chebush( d - 2 , x );
end

end