trigger BatchTrigger on Account (after insert) {
updateAccountPhone uap = new updateAccountPhone();
database.executeBatch(uap);
BatchPostalCode bpc = new BatchPostalCode();
database.executeBatch(bpc);

}