# car_rental_ui

Flutter application for car rental which does calls on the backend.

## Openapi code generator

To generate the code from openapi.yaml file that comes from the backend, you need to follow the
steps:

1. Make sure you have installed the openapi generator cli globally using npm. If not, run the
   command:

```shell script
npm install @openapitools/openapi-generator-cli -g 
```

1. Run the command to generate the code:

```shell script
npx @openapitools/openapi-generator-cli generate -i api_clients/openapi.yaml -g dart -o lib/generated_code
```

To test on emulator, put this string on backend path on api_client.dart (it references the machine
ip):
static String baseURL = 'http://10.0.2.2:8081';

Flutter
To use a svg as an icon, use:
ColorFiltered(
colorFilter: const ColorFilter.mode(AppColors.blue, BlendMode.srcIn),
child: SvgPicture.asset(
Images.closeIcon,
),
),

Libraries:
dontnv is used to read properties from .env file

On the main.dart, we set up files to use the colors defined there by default and also the font that
is there.

To get the width of the screen, put this code:
MediaQuery.of(context).size.width

To create a TextButton without padding on the sides, use:
TextButton(
onPressed: () {},
style: TextButton.styleFrom(
minimumSize: Size.zero,
padding: EdgeInsets.zero,
tapTargetSize: MaterialTapTargetSize.shrinkWrap,
),