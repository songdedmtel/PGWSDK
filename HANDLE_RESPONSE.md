# Handle Response from SDK

Response code from PGW SDK

| Response Code |Platform|              Payment Flow              |                                                         Action Required                                                         |
|:-------------:| :-----: |:--------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------------:|
|     1000      |Web / Mobile|Load redirect URL with IFrame / Webview.|                  Client should close the iframe when the URL is loading RESULT URL and read the BODY message.                   |
|     1001      |Web / Mobile|Do full redirect to 3rd party web page.|                                         None, end of payment flow after full redirect.                                          |
|     1002      |Web / Mobile|Load redirect URL with multiple tab in external web browser or Load redirect Scheme URL to open 3rd party application that do not do call back.| Mobile: on app RESUME, call get Transaction status API. WEB: need to do a looping query or long post to get transaction status. |
|     1003      |Web / Mobile|Get Alternative Payment Method (123) payslip information and set transaction status PENDING.|                                   Get payslip info, and display payslip. End of payment flow.                                   |
|     1004      |Mobile|Redirect to external app with app scheme, and back with app call back.|                                          Receive call back from 3rd party application.                                          |
|     1005      |Web / Mobile|Display generated QR information for scan.|                          After display QR, do a looping query or long post to get transaction status.                           |
|     2000      |Web / Mobile|Transaction completed, perform payment inquiry to get payment status and full response.|                            Get payment result, and display result to customer. End of payment flow.                             |
|     2001      |Web / Mobile|Transaction in progress.|                             Recursive transaction status inquiry API until getting payment result.                              |
|     2002      |Web / Mobile|Transaction not found.|                                                   Display result to customer.                                                   |
|     2003      |Web / Mobile|Failed To Inquiry.|                                                   Display result to customer.                                                   |
|  Other Code   |Web / Mobile|Transaction failed or rejected, perform payment inquiry to get payment status and full response.|                            Get payment result, and display result to customer. End of payment flow.                             |

For more information please follow this link [Payment Flow Response Code](https://developer.2c2p.com/docs/payment-flow-response-code)

