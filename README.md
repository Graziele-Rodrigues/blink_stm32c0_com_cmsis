# Blink STM32C0 com CMSIS

Este repositório contém um exemplo de projeto "blink" desenvolvido para microcontroladores STM32C0, utilizando ferramentas de linha de comando como GCC, GDB, OpenOCD e CMSIS. O projeto foi configurado e testado no ambiente **Ubuntu instalado no WSL** (Windows Subsystem for Linux).

## Pré-requisitos

Antes de começar, certifique-se de ter o seguinte instalado/configurado:

1. **WSL com Ubuntu**
   - Para instalar o Ubuntu no WSL, execute no PowerShell:
     ```bash
     wsl.exe --install Ubuntu
     ```

2. **Atualize o sistema Ubuntu**
   - Execute os comandos:
     ```bash
     sudo apt update
     sudo apt upgrade -y
     ```

3. **Instale o GCC ARM**
   - Instale o compilador e ferramentas ARM:
     ```bash
     sudo apt install gcc-arm-none-eabi binutils-arm-none-eabi
     ```
   - Verifique a instalação com:
     ```bash
     arm-none-eabi-gcc --version
     ```

4. **Instale o OpenOCD**
   - Clone e compile a versão mais recente:
     ```bash
     git clone https://github.com/openocd-org/openocd.git
     cd openocd
     ./bootstrap
     ./configure
     make -j$(nproc)
     sudo make install
     ```
   - Confirme a versão instalada:
     ```bash
     openocd --version
     ```

5. **Configure o acesso ao hardware USB no WSL**
   - Instale o driver USB/IP no Windows seguindo este [guia oficial](https://learn.microsoft.com/en-us/windows/wsl/connect-usb).
   - No PowerShell, liste os dispositivos USB conectados:
     ```bash
     usbipd list
     ```
   - Anexe o dispositivo ao WSL:
     ```bash
     usbipd bind --busid <busid>
     usbipd attach --wsl --busid <busid>
     ```
   - Verifique os dispositivos conectados no WSL:
     ```bash
     lsusb
     ```

---

## Testando a instalação

### Verificando o GCC ARM

1. Crie uma pasta para testes:
   ```bash
   mkdir ~/teste-gnu
   cd ~/teste-gnu
   ```
2. Abra o VS Code na pasta criada:
   ```bash
   code .
   ```
3. Crie um arquivo `test.c` com o seguinte código:
   ```c
   #include <stdint.h>

   void _exit(int status) {
       while (1);
   }

   int main() {
       while (1);  // Loop infinito
       return 0;
   }
   ```
4. Compile o código:
   ```bash
   arm-none-eabi-gcc -mcpu=cortex-m0 -mthumb -o test.elf test.c
   ```

Se o arquivo `test.elf` for gerado sem erros, a instalação do GCC está funcional.

---

## Sobre o projeto

O exemplo "blink" é configurado para utilizar a biblioteca **CMSIS**, com a seguinte estrutura básica:

- **CMSIS**: Biblioteca padrão ARM para abstração de hardware.
- **Makefile**: Automação de build.
- **OpenOCD**: Ferramenta para depuração e gravação no microcontrolador.

---

## Build e Flash

### Compilação
Para compilar o projeto, use:
```bash
make
```

### Gravação no microcontrolador
Utilize o OpenOCD para gravar o firmware no dispositivo:
```bash
sudo openocd -f interface/stlink.cfg -f target/stm32c0x.cfg
```

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

