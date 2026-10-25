#include "ece2_474.h"
#include "main.h"
#include <stdint.h>
#include <stdio.h>

void ece2_474_init(void) {}
void polling_routine(void){int ch=getchar();if(ch!=EOF){uint8_t data=(uint8_t)ch;HAL_StatusTypeDef result=HAL_UART_Transmit(&huart3,&data,1U,100U);printf("문자: %c, 바이트: 0x%02X, 전송 결과: %d\r\n",ch,(unsigned)data,(int)result);}}

static void tim6_isr_p4(void) {}
static void uart3_isr_p5(void) {}
static void uart2_isr_p6(void) {}
static void button_isr_p7(void) {}
static void gpio_in_pullup_isr_p8_ece2(void) {}
static void gpio_in_pulldown_isr_p9_ece2(void) {}
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin){if(GPIO_Pin==BUTTON_ece2_Pin)button_isr_p7();else if(GPIO_Pin==GPIO_IN_PULLUP_ece2_Pin)gpio_in_pullup_isr_p8_ece2();else if(GPIO_Pin==GPIO_IN_PULLDOWN_ece2_Pin)gpio_in_pulldown_isr_p9_ece2();}
void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim){if(htim->Instance==TIM6)tim6_isr_p4();}
void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart){if(huart->Instance==USART2)uart2_isr_p6();else if(huart->Instance==USART3)uart3_isr_p5();}
