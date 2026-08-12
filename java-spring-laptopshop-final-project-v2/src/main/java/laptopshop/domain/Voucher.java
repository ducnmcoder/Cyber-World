package laptopshop.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import java.io.Serializable;

@Entity
@Table(name = "vouchers")
public class Voucher implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    @NotNull
    @NotEmpty(message = "Title cannot be empty")
    private String title;

    @NotNull
    @NotEmpty(message = "Description cannot be empty")
    private String description;

    @NotNull(message = "Discount Amount is required")
    private Double discountAmount;

    @NotNull
    @NotEmpty(message = "Discount Type cannot be empty")
    private String discountType; // FIXED or PERCENT

    @NotNull
    @NotEmpty(message = "Valid Until cannot be empty")
    private String validUntil;

    @NotNull
    @NotEmpty(message = "Status cannot be empty")
    private String status; // ACTIVE or INACTIVE

    private String appliesTo; // ALL, FACTORY, TARGET
    private String applyValue; // MACBOOK, GAMING, etc.

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(Double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public String getValidUntil() {
        return validUntil;
    }

    public void setValidUntil(String validUntil) {
        this.validUntil = validUntil;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAppliesTo() {
        return appliesTo;
    }

    public void setAppliesTo(String appliesTo) {
        this.appliesTo = appliesTo;
    }

    public String getApplyValue() {
        return applyValue;
    }

    public void setApplyValue(String applyValue) {
        this.applyValue = applyValue;
    }
}
