function EPF_value = EPF1( Image_handle,Image_origin )
% EPF ��Edge-preserving factor
% 2020.05.03 
% y�Ǵ�������ͼ����x��groundtruth
% Image_handle: y
% Image_origin: x
% EPF =
% (sum(deta_x-deta_x')*(delta_y-deta_y'))
% ---------------------------------------------��
% (sqrt(sum((deta_x-deta_x')^2*(deta_y-delta_y')^2)))
% deta_x'��deta_x�ľ�ֵ��deta_y'��deta_y�ľ�ֵ��
% deta_x����ʹ�� 3*3��-��-˹���Ӽ���

[m_ori,n_ori,~] = size(Image_origin);
[m_rec,n_rec,~] = size(Image_handle);
if m_rec > m_ori
    l_r = Image_handle(3:m_ori+2,:,1);
    l_g = Image_handle(3:m_ori+2,:,2);
    l_b = Image_handle(3:m_ori+2,:,3);
    Image_handle = cat(3,l_r,l_g,l_b);
end


Image_handle_gray = (rgb2gray(Image_handle))/255;
Image_origin_gray = (rgb2gray(Image_origin))/255;

lab=[0 1 0;1 -4 1; 0 1 0];

lab_I1 = filter2(lab,Image_handle_gray,'same');
lab_I2 = filter2(lab,Image_origin_gray,'same');
mean_I1 = mean(lab_I1(:));
mean_I2 = mean(lab_I2(:));

res1 = lab_I1-mean_I1;
res2 = lab_I2-mean_I2;

up = res1.*res2;

I1_p = power(res2,2);
I2_p = power(res1,2);

down_sum = sqrt(sum(I1_p(:))*sum(I2_p(:)));

EPF_value = sum(up(:))/down_sum;
end
