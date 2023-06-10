#include <stdio.h>
#include <stdlib.h>
#include "mysql.h"

#pragma comment(lib, "libmysql.lib")
#define MAX_QUERY 1024
const char* host = "localhost";
const char* user = "root";
const char* pw = "mysql";
const char* db = "project";

int main(void) {

	MYSQL* connection = NULL;
	MYSQL conn;
	MYSQL_RES* sql_result;
	MYSQL_ROW sql_row;

	if (mysql_init(&conn) == NULL)
		printf("mysql_init() error!");

	connection = mysql_real_connect(&conn, host, user, pw, db, 3306, (const char*)NULL, 0);
	if (connection == NULL)
	{
		printf("%d ERROR : %s\n", mysql_errno(&conn), mysql_error(&conn));
		return 1;
	}

	else
	{
		printf("Connection Succeed\n");

		if (mysql_select_db(&conn, db))
		{
			printf("%d ERROR : %s\n", mysql_errno(&conn), mysql_error(&conn));
			return 1;
		}
		//database connection
		FILE* fp = NULL;
		const char* query_1;
		fopen_s(&fp,"20191617_1.txt", "r");
		if (fp != NULL) {
			char temp[MAX_QUERY];
			while (!feof(fp)) {
				query_1 = fgets(temp, sizeof(temp), fp);
				mysql_query(connection, query_1);
			}
			fclose(fp);
		}
		else {
			printf("file open error\n");
			return 1;
		}
		while (1) {
			printf("------- SELECT QUERY TYPES -------\n\n");
			printf("\t1. TYPE I\n");
			printf("\t2. TYPE II\n");
			printf("\t3. TYPE III\n");
			printf("\t4. TYPE IV\n");
			printf("\t5. TYPE V\n");
			printf("\t0. QUIT\n\n");
			int type;
			printf("Which Type? : ");
			scanf_s("%d", &type);
			printf("\n");
			if (type == 0) break;
			else if(type == 1) {
				int sub_type, t_num;//sub type 변수와 truck number 변수
				while (1) {
					printf("---- TYPE I ----\n\n");
					printf("Which truck number? : ");
					scanf_s("%d", &t_num);
					printf("\n");
					printf("---- Subtypes in TYPE I ----\n\n");
					printf("\t1. TYPE I-1.\n");
					printf("\t2. TYPE I-2.\n");
					printf("\t3. TYPE I-3.\n\n");
					printf("Which Sub Type? : ");
					scanf_s("%d", &sub_type);
					if (sub_type == 1) { // I-1
						printf("\n");
						printf("** Find all customers who had a package on the truck at the time of the crash **\n");
						char* query = (char*)malloc(MAX_QUERY * sizeof(char));
						if (query == NULL) {
							printf("Failed to allocate memory for query. \n");
							return 1;
						}
						sprintf_s(query, MAX_QUERY,"SELECT c.customer_id, c.name FROM Package p INNER JOIN Customer c ON p.customer_id = c.customer_id INNER JOIN Recipient r ON p.recipient_id = r.recipient_id INNER JOIN Pack_ship ps ON p.package_id = ps.package_id INNER JOIN Shippment s ON ps.shippment_id = s.shippment_id INNER JOIN Trans_use tu ON s.shippment_id = tu.shippment_id INNER JOIN Transportation t ON tu.transportation_id = t.transportation_id WHERE t.transportation_id = % d AND tu.start_time = ( SELECT MAX(start_time) FROM Trans_use WHERE transportation_id = % d ); ", t_num, t_num);
						int state = 0;

						state = mysql_query(connection, query);
						if (state == 0)
						{
							sql_result = mysql_store_result(connection);
							if (sql_result == NULL) {
								printf("No matching records found.\n");
							}
							else {
								printf("crashed truck number : %d\n", t_num);
								while ((sql_row = mysql_fetch_row(sql_result)) != NULL)
								{
									printf("[ID] : %s [Name] : %s\n", sql_row[0], sql_row[1]);
								}
							}
							mysql_free_result(sql_result);
						}
						free(query);
					}
					else if (sub_type == 2) {// I-2
						printf("\n");
						printf("** Find all recipients who had a package on that truck at the time of the crash **\n");
						char* query = (char*)malloc(MAX_QUERY * sizeof(char));
						if (query == NULL) {
							printf("Failed to allocate memory for query. \n");
							return 1;
						}
						sprintf_s(query, MAX_QUERY, "SELECT r.recipient_id, r.name FROM Package p INNER JOIN Customer c ON p.customer_id = c.customer_id INNER JOIN Recipient r ON p.recipient_id = r.recipient_id INNER JOIN Pack_ship ps ON p.package_id = ps.package_id INNER JOIN Shippment s ON ps.shippment_id = s.shippment_id INNER JOIN Trans_use tu ON s.shippment_id = tu.shippment_id INNER JOIN Transportation t ON tu.transportation_id = t.transportation_id WHERE t.transportation_id = % d AND tu.start_time = ( SELECT MAX(start_time) FROM Trans_use WHERE transportation_id = % d); ", t_num, t_num);
						int state = 0;

						state = mysql_query(connection, query);
						if (state == 0)
						{
							sql_result = mysql_store_result(connection);
							if (sql_result == NULL) {
								printf("No matching records found.\n");
							}
							else {
								printf("crashed truck number : %d\n", t_num);
								while ((sql_row = mysql_fetch_row(sql_result)) != NULL)
								{
									printf("[ID] : %s [Name] : %s\n", sql_row[0], sql_row[1]);
								}
							}
							mysql_free_result(sql_result);
						}
						free(query);
					}
					else if (sub_type == 3) {// I-3
						printf("\n");
						printf("** Find the last successful delivery by that truck prior to the crash.**\n");
						char* query = (char*)malloc(MAX_QUERY * sizeof(char));
						if (query == NULL) {
							printf("Failed to allocate memory for query. \n");
							return 1;
						}
						sprintf_s(query, MAX_QUERY, "SELECT tu.shippment_id, tu.transportation_id, tu.start_time, tu.end_time FROM Trans_use tu WHERE tu.transportation_id = %d AND tu.start_time < ( SELECT MAX(start_time) FROM Trans_use WHERE transportation_id = %d ) ORDER BY tu.start_time DESC LIMIT 1; ",t_num, t_num);
						int state = 0;

						state = mysql_query(connection, query);
						if (state == 0)
						{
							sql_result = mysql_store_result(connection);
							if (sql_result == NULL) {
								printf("No matching records found.\n");
							}
							else {
								while ((sql_row = mysql_fetch_row(sql_result)) != NULL)
								{
									printf("[Shippment_ID] : %s\n[Truck] : %s\n[Start] : %s\n[End] : %s\n", sql_row[0], sql_row[1], sql_row[2], sql_row[3]);
								}
							}
							mysql_free_result(sql_result);
						}
						free(query);
					}
					else if (sub_type == 0) break;
					printf("\n\n");
					
				}
			}
			else if (type == 2) {// II
				int year;
				printf("---- TYPE II ----\n\n");
				printf("** Find the customer who has shipped the most packages in certain year**\n");
				printf("Wich Year? : ");
				scanf_s("%d", &year);
				printf("\n");
				char* query = (char*)malloc(MAX_QUERY * sizeof(char));
				if (query == NULL) {
					printf("Failed to allocate memory for query.\n");
					return 1;
				}
				sprintf_s(query	, MAX_QUERY,"SELECT c.customer_id, c.name, p.total_payments FROM Customer c JOIN( SELECT customer_id, COUNT(*) AS total_payments FROM Payment WHERE YEAR(pay_date) = %d GROUP BY customer_id ) p ON c.customer_id = p.customer_id WHERE p.total_payments = ( SELECT MAX(total_payments) FROM( SELECT COUNT(*) AS total_payments FROM Payment WHERE YEAR(pay_date) = %d GROUP BY customer_id ) temp ); ",year, year);
				int state = 0;

				state = mysql_query(connection, query);
				if (state == 0)
				{
					sql_result = mysql_store_result(connection);
					if (sql_result == NULL) {
						printf("No matching records found.\n");
					}
					else {
						while ((sql_row = mysql_fetch_row(sql_result)) != NULL)
						{
							printf("[ID] : %s, [Name] : %s, %s Times\n", sql_row[0], sql_row[1], sql_row[2]);
						}
					}
					mysql_free_result(sql_result);
				}
				free(query);
				printf("\n\n");
			}
			else if (type == 3) { //III
				int year;
				printf("---- TYPE III ----\n\n");
				printf("** Find the customer who has spent the most money on shipping in the past year **\n");
				printf("Wich Year? : ");
				scanf_s("%d", &year);
				char* query = (char*)malloc(MAX_QUERY * sizeof(char));
				if (query == NULL) {
					printf("Failed to allocate memory for query.\n");
					return 1;
				}
				sprintf_s(query, MAX_QUERY, "SELECT c.customer_id, c.name, SUM(p.amount) AS total_amount FROM Customer c JOIN Payment p ON c.customer_id = p.customer_id WHERE YEAR(p.pay_date) = %d GROUP BY c.customer_id, c.name HAVING SUM(p.amount) = ( SELECT MAX(total_amount) FROM( SELECT SUM(amount) AS total_amount FROM Payment WHERE YEAR(pay_date) = %d GROUP BY customer_id ) temp ); ",year, year);
				int state = 0;

				state = mysql_query(connection, query);
				if (state == 0)
				{
					sql_result = mysql_store_result(connection);
					if (sql_result == NULL) {
						printf("No matching records found.\n");
					}
					else {
						while ((sql_row = mysql_fetch_row(sql_result)) != NULL)
						{
							printf("[ID] : %s , [Name] : %s, [Amount] : %s\n", sql_row[0], sql_row[1], sql_row[2]);
						}
					}
					mysql_free_result(sql_result);
				}
				free(query);
				printf("\n\n");
			}
			else if (type == 4) { //IV
				printf("---- TYPE IV ----\n\n");
				printf("** Find the packages that were not delivered within the promised time. **\n");
				char* query = (char*)malloc(MAX_QUERY * sizeof(char));
				if (query == NULL) {
					printf("Failed to allocate memory for query.\n");
					return 1;
				}
				sprintf_s(query, MAX_QUERY, "SELECT p.package_id FROM Service s JOIN Package p ON s.service_id = p.service_id WHERE s.timeliness < s.arrive_time");
				int state = 0;

				state = mysql_query(connection, query);
				if (state == 0)
				{
					sql_result = mysql_store_result(connection);
					if (sql_result == NULL) {
						printf("No matching records found.\n");
					}
					else {
						while ((sql_row = mysql_fetch_row(sql_result)) != NULL)
						{
							printf("[ID] : %s\n", sql_row[0]);
						}
					}
					mysql_free_result(sql_result);
				}
				free(query);
				printf("\n\n");
			}
			else if (type == 5) { //V year month 입력으로 해야됨
				char year[10];
				char month[5];
				printf("---- TYPE V ----\n\n");
				printf("** Generate the bill for each customer for the past month. Consider creating several types of bills. **\n");
				printf("Wich Year? : ");
				scanf_s("%s", year, sizeof(year));
				printf("Wich Month? : ");
				scanf_s("%s", month, sizeof(month));
				char* query = (char*)malloc(MAX_QUERY * sizeof(char)); // simple type
				if (query == NULL) {
					printf("Failed to allocate memory for query.\n");
					return 1;
				}
				sprintf_s(query, MAX_QUERY, "SELECT b.customer_id, c.name, c.address, SUM(p.amount) AS total_amount FROM Bill b JOIN Customer c ON b.customer_id = c.customer_id JOIN Bill_pay bp ON b.bill_id = bp.bill_id JOIN Payment p ON bp.payment_id = p.payment_id WHERE YEAR(b.bill_date) = %s AND MONTH(b.bill_date) = %s GROUP BY b.customer_id, c.address; ", year, month);
				int state = 0;

				state = mysql_query(connection, query);
				if (state == 0)
				{
					sql_result = mysql_store_result(connection);
					if (sql_result == NULL) {
						printf("No matching records found.\n");
					}
					else {
						printf("*** Simple Bill ***\n");
						while ((sql_row = mysql_fetch_row(sql_result)) != NULL)
						{
							printf("---------------------------------------------------------------------\n");
							printf("|%4s-%2s                                                            |\n",year,month);
							printf("| %5s | %15s | %30s | %6s |\n", "ID", "Name", "Address", "Amout");
							printf("| %5s | %15s | %30s | %6s |\n", sql_row[0], sql_row[1], sql_row[2], sql_row[3]);
							printf("---------------------------------------------------------------------\n");
						}
					}
					mysql_free_result(sql_result);
				}
				free(query);
				printf("\n\n");
				query = (char*)malloc(MAX_QUERY * sizeof(char)); //A bill listing charges by type of service. type of service 전부나열 package 별로, 돈,
				if (query == NULL) {
					printf("Failed to allocate memory for query.\n");
					return 1;
				}
				int prev_id = 0;
				sprintf_s(query, MAX_QUERY, "SELECT b.customer_id, c.name AS customer_name, bp.payment_id, p.amount, pk.service_id, s.type_of_package FROM Bill b JOIN Customer c ON b.customer_id = c.customer_id JOIN Bill_pay bp ON b.bill_id = bp.bill_id JOIN Payment p ON bp.payment_id = p.payment_id JOIN Package pk ON p.package_id = pk.package_id JOIN Service s ON pk.service_id = s.service_id WHERE YEAR(b.bill_date) = %s AND MONTH(b.bill_date) = %s; ", year, month);
				state = 0;
				state = mysql_query(connection, query);
				if (state == 0)
				{
					sql_result = mysql_store_result(connection);
					if (sql_result == NULL) {
						printf("No matching records found.\n");
					}
					else {
						printf("*** Service Bill ***\n");
						while ((sql_row = mysql_fetch_row(sql_result)) != NULL)
						{
							int c_id = atoi(sql_row[0]);
							if (c_id != prev_id) {
								printf("|---------|-----------------|---------|---------|-----------------|-----------------|\n");
								printf("|%4s-%2s                                                                            |\n",year, month);
								printf("|%9s|%17s|%9s|%9s|%17s|%17s|\n", "ID", "Name", "Bill_ID", "Amount", "Service_ID", "Box");
							}
							printf("| %7s | %15s | %7s | %7s | %15s | %15s |\n", sql_row[0], sql_row[1], sql_row[2], sql_row[3], sql_row[4], sql_row[5]);
							prev_id = c_id;
						}
						printf("|---------|-----------------|---------|---------|-----------------|-----------------|\n");
					}
					mysql_free_result(sql_result);
				}
				free(query);
				printf("\n\n");
				query = (char*)malloc(MAX_QUERY * sizeof(char)); //An itemize billing listing each individual shipment and the charges for it
				if (query == NULL) {
					printf("Failed to allocate memory for query.\n");
					return 1;
				}
				prev_id = 0;
				sprintf_s(query, MAX_QUERY, "SELECT b.customer_id, c.name AS customer_name, p.amount, pk.package_id, s.weight, s.type_of_package FROM Bill b JOIN Customer c ON b.customer_id = c.customer_id JOIN Bill_pay bp ON b.bill_id = bp.bill_id JOIN Payment p ON bp.payment_id = p.payment_id JOIN Package pk ON p.package_id = pk.package_id JOIN Service s ON pk.service_id = s.service_id WHERE YEAR(b.bill_date) = %s AND MONTH(b.bill_date) = %s; ", year, month);
				state = 0;
				state = mysql_query(connection, query);
				if (state == 0)
				{
					sql_result = mysql_store_result(connection);
					if (sql_result == NULL) {
						printf("No matching records found.\n");
					}
					else {
						printf("*** Itemize Bill ***\n");
						while ((sql_row = mysql_fetch_row(sql_result)) != NULL)
						{
							int c_id = atoi(sql_row[0]);
							if (c_id != prev_id) {
								printf("|---------|-----------------|---------|---------|---------|--------------|\n");
								printf("|%4s-%2s                                                                 |\n",year,month);
								printf("|%9s|%17s|%9s|%9s|%9s|%14s|\n", "ID", "Name", "Amout", "Pack_ID", "Weight", "Box");
							}
							printf("| %7s | %15s | %7s | %7s | %7s | %12s |\n", sql_row[0], sql_row[1], sql_row[2], sql_row[3], sql_row[4], sql_row[5]);
							prev_id = c_id;
						}
						printf("|---------|-----------------|---------|---------|---------|--------------|\n");
					}
					mysql_free_result(sql_result);
				}
				free(query);
				printf("\n\n");
			}
		}
		FILE* fp2 = NULL;
		const char* query_2;
		fopen_s(&fp2,"20191617_2.txt", "r");
		if (fp2 != NULL) {
			char temp[MAX_QUERY];
			while (!feof(fp2)) {
				query_2 = fgets(temp, sizeof(temp), fp2);
				mysql_query(connection, query_2);
			}
			fclose(fp2);
		}
		mysql_close(connection);
	}

	return 0;
}
