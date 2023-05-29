package co.com.pearls.certification.mazatlan.tasks;

import co.com.pearls.certification.mazatlan.interactions.DesplazarPantalla;
import co.com.pearls.certification.mazatlan.userinterfaces.LoginSection;
import co.com.pearls.certification.mazatlan.utils.constants.Constants;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;

import static co.com.pearls.certification.mazatlan.userinterfaces.LoginSection.*;

public class LoginMazatlan implements Task {
    @Override
    public <T extends Actor> void performAs(T actor) {
        actor.attemptsTo(
                Enter.theValue(Constants.NAME).into(LoginSection.TXT_NAME),
                Enter.theValue(Constants.NICKNAME).into(LoginSection.TXT_NICKNAME),
                Enter.theValue(Constants.NUMBERSHIRT).into(LoginSection.TXT_NUMBERSHIRT),
                Click.on(CLIC_FANDATE),
                Click.on(SELECT_FANDATE),
                Click.on(SELECT_IMAGE),
                DesplazarPantalla.haciaArriba(),
                Click.on(CLIC_BUTTON)

        );
    }

    public static LoginMazatlan withUser() {
        return new LoginMazatlan();
    }
}
