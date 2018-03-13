<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width">
	<title>BrandName | Newsletter</title>
	<link rel="stylesheet" href="css/style.css">
	<style>
		@media(max-width: 1024px) {
			.container {
				width: 96%;
			}		
		}
	</style>
</head>
<body>
	<header>
		<div class="container brand">
			<h1>Admin Login</h1>		
		</div>
	</header>
	<div class="content container">
		<form action="Login">
			<p style="font-weight: bold; font-size: 22; color: #2c3e50; margin-bottom: 10px;">Username:</p>
			<input type="text" name="user">
			<p style="font-weight: bold; font-size: 22; color: #2c3e50; margin-bottom: 10px;">Password:</p>
			<input type="password" name="pass">
			<button class="button1" type="submit" value="Login">Login</button>
		</form>
		<form action="index.jsp" method="get">
			<button style="margin-top: 15px;" type="submit" class="button1">Back</button>
		</form>
	</div>		
</body>
</html>