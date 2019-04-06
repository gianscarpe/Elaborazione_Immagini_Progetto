
function moment_descriptor = computeHuMomentsDescriptor(image)
	n02 = norm_central_moment_PQ(image, 0, 2);
	n03 = norm_central_moment_PQ(image, 0, 3);
	n11 = norm_central_moment_PQ(image, 1, 1);
	n12 = norm_central_moment_PQ(image, 1, 2);
	n20 = norm_central_moment_PQ(image, 2, 0);
	n21 = norm_central_moment_PQ(image, 2, 1);
	n30 = norm_central_moment_PQ(image, 3, 0);

	%% First invariant moment
	p1 = n20 + n02;

	%% Second invariant moment
	p2 = (n20 - n02)^2 + 4*n11^2;

	%% Third invariant moment
	p3 = (n30 - 3*n12)^2 + (3*n21 - n03)^2;

	%% Fourth invariant moment
	p4 = (n30 + n12)^2 + (n21 + n03)^2;

	%% Fifth invariant moment
	p5 = (n30 - 3*n12) * (n30 + n12) * ((n30 + n12)^2 - 3*(n21 + n03)^2) + ...
		 (3*n21 - n03) * (n21 + n03) * (3*(n30 + n12)^2 - (n21 + n03)^2);

	%% Sixth invariant moment
	p6 = (n20 - n02) * ((n30 + n12)^2 - (n21 + n03)^2) + 4*n11*(n30 + n12) * (n21 + n03);

	%% Seventh invariant moment
	p7 = (3*n21 - n03) * (n30 + n12) * ((n30 + n12)^2 - 3*(n21 + n03)^2) - ...
		 (n30 - 3*n12) * (n21 + n03) * (3*(n30 + n12)^2 - (n21 + n03)^2);
	

	%% Descriptor for i-th image
	moment_descriptor(1, 1) = p1;
	moment_descriptor(1, 2) = p2;
	moment_descriptor(1, 3) = p3;
	moment_descriptor(1, 4) = p4;
	moment_descriptor(1, 5) = p5;
	moment_descriptor(1, 6) = p6;
	moment_descriptor(1, 7) = p7;

%	moment_descriptor = compute_phi(compute_eta(compute_m(image)));
end

%% Auxiliar functions
function n = norm_central_moment_PQ(image, p, q)
	n = central_moment_PQ(image, p, q) / (central_moment_PQ(image, 0, 0) ^ (0.5 * (p + q) + 1));
end

function c = central_moment_PQ(image, p, q)
	[M, N] = size(image);
	m00 = sum(sum(image));
	x = moment_PQ(image, 1, 0) / m00;
	y = moment_PQ(image, 0, 1) / m00;
	c = ((0:M-1) - x).^p * image * (((0:N-1) - y).^q)';
end

function m = moment_PQ(image, p, q)
	[M, N] = size(image);
	m = (0:M-1).^p * image *((0:N-1).^q)';
end


function m = compute_m(F)
	[M, N] = size(F);
	[x, y] = meshgrid(1:N, 1:M);
	x = x(:);
	y = y(:);
	F = F(:);
	m.m00 = sum(F);
	if (m.m00 == 0)
		m.m00 = eps;
	end
	m.m10 = sum(x .* F);
	m.m01 = sum(y .* F);
	m.m11 = sum(x .* y .* F);
	m.m20 = sum(x.^2 .* F);
	m.m02 = sum(y.^2 .* F);
	m.m30 = sum(x.^3 .* F);
	m.m03 = sum(y.^3 .* F);
	m.m12 = sum(x .* y.^2 .* F);
	m.m21 = sum(x.^2 .* y .* F);
end

function e = compute_eta(m)
	xbar = m.m10 / m.m00;
	ybar = m.m01 / m.m00;
	e.eta11 = (m.m11 - ybar*m.m10) / m.m00^2;
	e.eta20 = (m.m20 - xbar*m.m10) / m.m00^2;
	e.eta02 = (m.m02 - ybar*m.m01) / m.m00^2;
	e.eta30 = (m.m30 - 3*xbar*m.m20 + 2*xbar^2*m.m10) / m.m00^2.5;
	e.eta03 = (m.m03 - 3*ybar*m.m02 + 2*ybar^2*m.m01) / m.m00^2.5;
	e.eta21 = (m.m21 - 2*xbar*m.m11 -ybar*m.m20 + 2*xbar^2*m.m01) / m.m00^2.5;
	e.eta12 = (m.m12 - 2*ybar*m.m11 - xbar*m.m02 + 2*ybar^2*m.m10) / m.m00^2.5;
end

function phi = compute_phi(e)
	phi(1) = e.eta20 + e.eta02;
	phi(2) = (e.eta20 - e.eta02)^2 + 4*e.eta11^2;
	phi(3) = (e.eta30 - 3*e.eta12)^2 + (3*e.eta21 - e.eta03)^2;
	phi(4) = (e.eta30 + e.eta12)^2 + (e.eta21 + e.eta03)^2;
	phi(5) = (e.eta30 - 3*e.eta12) * (e.eta30 + e.eta12) * ( (e.eta30 + e.eta12)^2 - 3*(e.eta21 + e.eta03)^2 ) + (3*e.eta21 - e.eta03) * (e.eta21 + e.eta03) * ( 3*(e.eta30 + e.eta12)^2 - (e.eta21 + e.eta03)^2 );
	phi(6) = (e.eta20 - e.eta02) * ( (e.eta30 + e.eta12)^2 - (e.eta21 + e.eta03)^2 ) + 4*e.eta11*(e.eta30 + e.eta12)*(e.eta21 + e.eta03);
	phi(7) = (3*e.eta21 - e.eta03) * (e.eta30 + e.eta12) * ( (e.eta30 + e.eta12)^2 - 3*(e.eta21 + e.eta03)^2 ) + (3*e.eta12 - e.eta30) * (e.eta21 + e.eta03) * ( 3*(e.eta30 + e.eta12)^2 - (e.eta21 + e.eta03)^2 );
end