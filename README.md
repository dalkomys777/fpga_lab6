# FPGA LAB6 · STM32_2 UART / 서보·SRAM·DAC

2026년 10월 26일 실험 전 준비 저장소다. STM32 과제 5~7 교체 코드와 FPGA UART LED, 서보, SRAM, DAC의 RTL·자기검사 테스트벤치·Vivado 프로젝트 생성 파일을 포함한다.

## 준비된 항목

| 구분 | 폴더 | 사전 검증 |
|---|---|---|
| STM32 과제5 | `stm32/task5_pc_echo/` | 문자와 16진수 바이트 출력 |
| STM32 과제6 | `stm32/task6_mcu_to_fpga/` | UART3로 한 바이트 전달 |
| STM32 과제7 | `stm32/task7_uart_led/` | 과제6 송신 + FPGA LED 명령 |
| FPGA UART LED | `circuits/00_uart_led/` | 9600 8N1 수신·에코·0/1/2 명령 |
| 서보 | `circuits/01_servo/` | 20 ms 프레임, 1/1.5/2 ms, 상·하한 |
| SRAM | `circuits/02_sram/` | 16주소 읽기·쓰기·버스 해제·충돌 차단 |
| DAC | `circuits/03_dac/` | 260회 쓰기·255→0·채널·데이터 유지 |

## 실행 순서

1. `LAB6.code-workspace`를 연다.
2. `Terminal > Run Task...`에서 원하는 회로의 `Simulate`를 실행한다.
3. 터미널의 `PASS`와 `build/sim/wave.vcd`를 확인한다.
4. 같은 회로의 `Open waveform`을 실행하고 VaporView로 파형을 연다.
5. Vivado는 루트의 `create_projects.tcl`을 실행하거나 생성된 `.xpr`을 연다.

## 장비 연결 전에 반드시 확인할 핀

공통 클록 B6, 리셋 K4, USB-UART RX C6/TX F6, LED0 N5는 기존 실습 핀표로 확정했다. UART의 기본 XDC는 보드 USB-UART 자체시험용 RX C6이다. 실제 과제6·7에서 STM32 PC10을 연결할 때는 `lab6_uart_led_mcu_rx_template.xdc`의 `MCU_RX_PACKAGE_PIN`을 교재의 확장 GPIO 핀으로 바꾼다.

서보 출력과 SRAM·DAC 전용 핀은 장치 교재 핀표를 확인해야 한다. 해당 XDC에는 `TODO`가 명확히 남아 있으며, 잘못된 임의 핀을 넣지 않았다. 교재 핀표 사진을 받으면 그 값만 채우면 된다.

## STM32

`stm32/tools/activate_and_build.ps1 -Task task5|task6|task7`로 선택한 완성본을 `ece2_474`에 활성화하고 빌드한다. 원본은 자동 백업한다. Serial Monitor는 9600, 8N1, 줄바꿈 None으로 설정한다.

## 출처

- `ece2_474/docs/STM32_2.md`
- `ece2_474/docs/FPGA_additional.md`
