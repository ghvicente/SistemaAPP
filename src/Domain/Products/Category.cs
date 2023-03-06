using Flunt.Validations;
using System.Diagnostics.Contracts;
using System.Linq.Expressions;

namespace SistemaAPP.Domain.Products
{
    public class Category : Entity
    {

        public string Name { get; private set; }  
        public bool Active { get; private set; }

        
        public Category(string name, string createdBy, string editedBy)
        {
            Name = name;
            Active = true;
            CreatedBy = createdBy;
            EditedBy = editedBy;
            CreatedOn = DateTime.Now;
            EditedOn = DateTime.Now;

            Validate();
        }

        public void EditInfo(string name, bool active, string editedBy)
        {
            Active = active;
            Name = name;
            EditedBy = editedBy;
            EditedOn = DateTime.Now;


            Validate();
        }

        private void Validate()
        {
            var contract = new Contract<Category>()
                .IsNotNullOrEmpty(Name, "Name", "Nome é obrigatório.")
                .IsGreaterOrEqualsThan(Name, 3, "Name", "Nome deve conter no mínimo 3 caracteres")
                .IsNotNullOrEmpty(CreatedBy, "CreatedBy")
                .IsNotNullOrEmpty(EditedBy, "EditedBy");
            AddNotifications(contract);
        }

    }
}
