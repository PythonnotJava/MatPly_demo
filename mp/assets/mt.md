# MatPly1.0.9版本MatrixType功能全览

## 矩阵基础操作

### visible

#### 可视化矩阵数据，可以使用set_visible_round设置输出格式

### visible_spc

#### 查看矩阵特殊的属性，在自定义拓展API一般才用到

### row_

#### 获取矩阵的某行向量

### column_

#### 获取矩阵的某列向量

### at

#### 获取矩阵某位置数据

### hasSameShape

#### 判断两个矩阵形状是不是一样

### compare

#### 两个相同形状的矩阵对比相同位置的数据大小

### cut

#### 获取矩阵内部剪切的某块

### cutfree

#### 从矩阵任意一点开始剪切，可以溢出矩阵区域

### concat

#### 拼接两个矩阵

### reshape

#### 矩阵大小不变，改变形状，源矩阵修改使用reshape_no_returned

### resize

#### 更改矩阵大小，源矩阵修改使用resize_no_returned

### sort

#### 矩阵数据排序，源矩阵修改使用sort_no_returned

### setMask

#### 覆盖矩阵中的nan、正负inf

### toList

#### 矩阵转二维列表

### flatten

#### 矩阵扁平化操作

### flatten_list

#### 获取扁平化到向量的矩阵，改方法已弃用并被toDoubleVector代替

### slice

#### 矩阵切片

### clip

#### 矩阵框住范围，源矩阵修改使用clip_no_returned

### rotate

#### 矩阵旋转

### mirror

#### 矩阵镜像

### fill_diagonal

#### 矩阵按照最小维度进行对角线填充

### concats

#### 多矩阵拼接

### split

#### 矩阵任意拆分为多个子矩阵

### split_equal

#### 将矩阵均分为多个子矩阵

### cover

#### 使用一个矩阵从被操作矩阵的内部开始覆盖

### stretch

#### 矩阵的拉伸方法

### toDoubleVector

#### 获取扁平化的浮点类型向量

### toIntVector

#### 获取扁平化的整型向量

### toBoolVector

#### 获取扁平化的布尔型向量

### MatrixType()

#### 默认构造函数

### toString

#### 打印矩阵信息

### filled

#### 获取填充矩阵

### ones

#### 全1矩阵

### zeros

#### 全0矩阵

### linspace

#### 范围均匀分割矩阵

### arrange

#### 自增1的矩阵

### fromPointer

#### 从底层指针构建矩阵

### deepCopy

#### 深拷贝

### range

#### 根据任意步长构建

### Diag

#### 生成对角矩阵

### Hist

#### 获取未经可视化的直方统计

### Bar

#### 获取未经可视化的柱状统计

## 纯数学

### acos

#### 反余弦函数

### asin

#### 反正弦函数

### atan

#### 反正切函数

### cos

#### 余弦函数

### sin

#### 正弦函数

### tan

#### 正切函数

### cosh

#### 双曲余弦函数

### sinh

#### 双曲正弦函数

### tanh

#### 双曲正切函数

### exp

#### 以e为底的指数函数

### log

#### 以e为底的对数函数

### log10

#### 以10为底的对数函数

### sqrt

#### 平方根函数

### ceil

#### 向上取整函数

### floor

#### 向下取整函数

### fabs

#### 绝对值函数

### sum

#### 求和

### mean

#### 均值

### min

#### 最小值

### max

#### 最大值

### power

#### 幂函数

### atan2

#### 弧度函数

### argmax

#### 最大值索引

### argmin

#### 最小值索引

### get_range

#### 数值范围区间

### cumsum

#### 累计求和

### sgn

#### 信号函数

### shake

#### 源矩阵数据随机偏移

## 线性代数

### E

#### 单位矩阵

### E_like

#### 最小维度下的类单位阶梯矩阵

### T_/transpose

#### 转置矩阵

### trace

#### 迹

### det

#### 方阵的行列式值

### inv

#### 非奇异矩阵的逆矩阵

### adj

#### 伴随矩阵

### rank

#### 矩阵的秩，通过set_round来解决计算机精度问题

### exchange_row

#### 初等行变换，交换

### exchange_column

#### 初等列变换，交换

### multiply_row

#### 初等行变换，倍乘

### multiply_column

#### 初等列变换，倍乘

### add_row

#### 初等行变换，加和

### add_column

#### 初等列变换，加和

### matmul

#### 左行右列做内积

### add

#### 矩阵加法，源矩阵修改使用add_no_returned

### minus

#### 矩阵减法，源矩阵修改使用minus_no_returned

### multiply

#### 矩阵乘法，源矩阵修改使用multiply_no_returned

### divide

#### 矩阵除法，源矩阵修改使用divide_no_returned

### kronecker

#### 克罗内克积

### cofactor

#### 划余子式矩阵

### rref

#### 最简阶梯型

### norm

#### 矩阵的n范数

### norm2

#### L2范数

### norm_inf

#### 无穷范数

### norm_negainf

#### 负无穷范数

### norm_one

#### L1范数

### norm_zero

#### L0范数

### normalization

#### 三种归一化

### qr

#### QR分解

## 概率论与数理统计

### normal

#### 均匀分布

### poisson

#### 泊松分布

### normal

#### 正态分布

### exponential

#### 指数分布

### gamma

#### 伽马分布

### binomial

#### 伯努利分布

### chisquare

#### 卡方分布

### tdis

#### t分布

### fdis

#### F分布

### geometric

#### 几何分布

### nbinomial

#### 负二项分布

### lognormal

#### 对数正态分布

### cauchydis

#### 柯西分布

### multinomial

#### 多项式分布

### beta

#### 贝塔分布

### wiener_process

#### 布朗运动

### wiener_process_stage

#### 布朗运动的某个时间戳

### dirichlet

#### 狄利克雷分布

### laplacedis

#### 拉普拉斯分布

### gumbel

#### 耿贝尔分布

### hypergeometric

#### 超几何分布

### logseries

#### 对数分布

### weibull

#### 韦伯分布

### triangular

#### 三角分布

### power_law

#### 幂律分布

### rayleigh

#### 瑞利分布

### stabledis

#### 稳定分布

### pareto

#### 帕累托分布

### rice

#### 莱斯分布

### wald

#### 沃德分布

### sigmoid

#### 激活函数

### softmax

#### 归一化指数函数

### shuffle

#### 随机打乱

### std

#### 标准差

### variance

#### 方差

### median

#### 中位数

### mode

#### 众数

### decentralizate

#### 数据去中心化

### covariance

#### 协方差

### cov

#### 协方差矩阵

### pearsonCoef

#### 皮尔逊系数

### MSE

#### 均方误差

### RMSE

#### 均方根误差

### MAE

#### 平方绝对误差

### MAPE

#### 平均绝对百分比误差

### R2

#### 决定系数

### SMAPE

#### 对称平均绝对百分比误差

### choice

#### 按概率挑选

## 微积分

### diff_center

#### 中心差分求导

## 纯函数工具

### replace

#### 条件约束下替换数据，源矩阵修改使用replace_no_returned

### where

#### 条件约束下的数据查询

### all

#### 全部满足条件判断

### any

#### 任意满足条件存在判断

### counter

#### 满足条件下的数据计数

### reduce

#### 条件下两个相临值的持续操作

### magic

#### 极其抽象的自定义条件函数，但，这就是魔法！

### clip_reverse

#### 条件下对数据反向框住，源矩阵修改使用clip_reverse_no_returned

### customize

#### 自定义行为变换数据

### findall

#### 查询符合条件的全部数据的索引

## 几何模拟

### ellipse_edge

#### 椭圆轮廓模拟

### ellipse_area

#### 椭圆区域模拟

### circle_edge

#### 圆轮廓模拟

### circle_area

#### 圆区域模拟

### line

#### 线性模拟

### triangle_edge

#### 三角形轮廓模拟

### triangle_area

#### 三角形区域模拟

### quadrilateral_edge

#### 四边形轮廓模拟

### quadrilateral_area

#### 四边形区域模拟

### heart_edge

#### 特定心形线轮廓模拟

### heart_area

#### 特定心形线区域模拟

### curve

#### 任意曲线模拟

### bezier

#### 贝塞尔曲线模拟

### rectangle_edge

#### 矩形边缘模拟

### rectangle_area

#### 矩形区域模拟

### custom_curve

#### 高定义度的曲线在直角坐标系模拟

### linewb

#### 使用系数进行一元线性模拟
